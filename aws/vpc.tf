#
# VPC Resources
#  * VPC
#  * Subnets
#  * Internet Gateway
#  * Route Table
#

resource "aws_vpc" "thornode" {
  cidr_block = "10.0.0.0/16"

  tags = map(
    "Name", "terraform-eks-thornode-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_subnet" "thornode" {
  count = 2

  availability_zone         = data.aws_availability_zones.available.names[count.index]
  cidr_block                = "10.0.${count.index}.0/24"
  map_public_ip_on_launch   = true
  vpc_id                    = aws_vpc.thornode.id

  tags = map(
    "Name", "terraform-eks-thornode-node",
    "kubernetes.io/cluster/${var.cluster-name}", "shared",
  )
}

resource "aws_internet_gateway" "thornode" {
  vpc_id = aws_vpc.thornode.id

  tags = {
    Name = "terraform-eks-thornode"
  }
}

resource "aws_route_table" "thornode" {
  vpc_id = aws_vpc.thornode.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.thornode.id
  }
}

resource "aws_route_table_association" "thornode" {
  count = 2

  subnet_id      = aws_subnet.thornode.*.id[count.index]
  route_table_id = aws_route_table.thornode.id
}
