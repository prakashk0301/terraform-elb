resource "aws_security_group" "sec-grp" {

    name = "sec-grp"

    vpc_id =  "${var.aws_vpc}"

    tags = {
        Name = "sec-grp"
    }
}

resource "aws_security_group_rule" "allow-ingress" {

        type            = "ingress"
        from_port       = "0"
        to_port         = "0"
        protocol        = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = "${aws_security_group.sec-grp.id}"
}

resource "aws_security_group_rule" "allow-egress" {

        type            = "egress"
        from_port       = "0"
        to_port         = "0"
        protocol        = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        security_group_id = "${aws_security_group.sec-grp.id}"
}

