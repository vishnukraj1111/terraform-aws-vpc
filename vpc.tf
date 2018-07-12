resource "aws_vpc" "company" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "Company"
    }
}

resource "aws_internet_gateway" "company" {
    vpc_id = "${aws_vpc.company.id}"
}


resource "aws_security_group" "company-sec-group" {
    name = "company-sec-group"
    description = "Allow all from same and 22 from IP"

 
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["XXX.XX.XX.XX/26"] #To allow from a specific IP
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"] #To allow from all IP's
    }
    
    ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.1.0.0/16"]
  }

    ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["172.31.0.0/16"] #IP range for VPC Peering to a different VPC
  }

    vpc_id = "${aws_vpc.company.id}"

    tags {
        Name = "company"
    }
}


/*
  Public Subnet
*/

resource "aws_subnet" "company-pub-sub-1a" {
    vpc_id = "${aws_vpc.company.id}"

    cidr_block = "${var.company-pub-sub-1a_cidr}"
    availability_zone = "ap-southeast-1a"

    tags {
        Name = "company-pub-sub-1a"
    }
}

resource "aws_subnet" "company-pub-sub-1b" {
    vpc_id = "${aws_vpc.company.id}"

    cidr_block = "${var.company-pub-sub-1b_cidr}"
    availability_zone = "ap-southeast-1b"

    tags {
        Name = "company-pub-sub-1b"
    }
}

resource "aws_subnet" "company-pub-sub-1c" {
    vpc_id = "${aws_vpc.company.id}"

    cidr_block = "${var.company-pub-sub-1c_cidr}"
    availability_zone = "ap-southeast-1c"

    tags {
        Name = "company-pub-sub-1c"
    }
}




resource "aws_route_table" "company-rt" {
    vpc_id = "${aws_vpc.company.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.company.id}"
    }
    route {
        cidr_block = "172.31.0.0/16"
        vpc_peering_connection_id = "pcx-XXXXX" #VPC Peering ID
    }

    tags {
        Name = "company-rt"
    }
}

resource "aws_main_route_table_association" "company-rt" {
  vpc_id         = "${aws_vpc.company.id}"
  route_table_id = "${aws_route_table.company-rt.id}"
}

resource "aws_route_table_association" "company-pub-sub-1a" {
    subnet_id = "${aws_subnet.company-pub-sub-1a.id}"
    route_table_id = "${aws_route_table.company-rt.id}"
}

resource "aws_route_table_association" "company-pub-sub-1b" {
    subnet_id = "${aws_subnet.company-pub-sub-1b.id}"
    route_table_id = "${aws_route_table.company-rt.id}"
}

resource "aws_route_table_association" "company-pub-sub-1c" {
    subnet_id = "${aws_subnet.company-pub-sub-1c.id}"
    route_table_id = "${aws_route_table.company-rt.id}"
}
