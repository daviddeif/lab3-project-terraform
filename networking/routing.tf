
# ----------------------internet  gateway for public--------------------
resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "my-igw"
    Environment = "${var.environment}"
  }
}
# ----------------------------nat for private------------------------
/* Elastic IP for NAT */
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.ig]
}


/* NAT */
resource "aws_nat_gateway" "nat" {
  count         = length(aws_subnet.public_subnet)
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet[count.index].id
  depends_on    = [aws_internet_gateway.ig]

  tags = {
    Name        = "demo-nat-${count.index + 1}"
    Environment = "${var.environment}"
  }
}
# ---------------------puplic route table---------------
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig.id
  }

  tags = {
    Name = "public_route"
  }
}

resource "aws_route_table_association" "public_route_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = module.aws_subnet.public_subnet[count.index].id 
  route_table_id = aws_route_table.public.id
}

# ---------------------private route table---------------
resource "aws_route_table" "private" {
  count  = length(aws_subnet.private_subnet)
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }
  tags = {
    Name = "private_route_${count.index + 1}"
  }
}

resource "aws_route_table_association" "private-route_association" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = module.aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private.id
}


