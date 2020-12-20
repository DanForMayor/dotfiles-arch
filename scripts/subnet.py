#!/usr/bin/python3
import argparse

"""

Little script for splitting subnets and outputting the address space of a specific subnet
and for calculating the first, last, broadcast, and mask for the subnet

Not super perfect, but as language agnostic as I was willing to make it
and does it with as much boolean math as I could stick in here


"""



def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("ipaddr", help="Address/prefix in the form: 10.100.16.128/27")
    parser.add_argument("-l", "--list", help="Quiets all output other than the list of addresses. Output is separated by newlines.", action="store_true")
    parser.add_argument("-f", "--full", help="All output is provided. Overrides other options.", action="store_true")
    args = parser.parse_args()
    displaySubnetInfo(args.ipaddr, args.full, args.list)

def printError(mesg):
    print(f"ERROR: {mesg}")
    exit(1)

def displaySubnetInfo(addressString, showFull, showList):

    splitAddr = addressString.split("/")
    if len(splitAddr) != 2 or not splitAddr[1].isnumeric(): printError(f"{addressString} is not a valid input")

    subnet          = getSubnetMask(int(splitAddr[1]))
    address         = convertAddress(splitAddr[0])
    networkAddress  = address & subnet
    broadcast       = networkAddress + ((~subnet) + (2<<31))

    if showFull or not showList:
        print("Network Address: %s"      %(intToAddressString(networkAddress)))
        print("First Address: %s"        %(intToAddressString(networkAddress + 1)))
        print("Last Address: %s"         %(intToAddressString(broadcast - 1)))
        print("Broadcast Address: %s"    %(intToAddressString(broadcast)))
        print("mask: %s"                 %(intToAddressString(subnet)))

    if showFull or showList:
        scannable = []
        for i in range(1, broadcast - networkAddress):
            scannable.append(intToAddressString(networkAddress + i))
            print(intToAddressString(networkAddress + i))

def getSubnetMask(hostBits):
    mask = (1 << hostBits) - 1
    while not (1 << 31 & mask):
        mask = mask << 1
    return mask

def convertAddress(addr):
    octets = addr.split(".")

    if len(octets) != 4: printError(f"{addr} is an invalid length")
    
    num = 0
    for octet in octets:
        if not octet.isnumeric() or int(octet) > 255 or int(octet) < 0: printError(f"{addr} contains an invalid octet: {octet}")
        num += int(octet)
        if octets.index(octet) != len(octets) -1:
            num = num << 8
    return num

def intToAddressString(num):
    address = ""
    for i in reversed(range(0,32,8)):
        address += str((num >> i) & 255)
        if i > 0:
            address += "."
    return address

if __name__ =="__main__":
    main()

