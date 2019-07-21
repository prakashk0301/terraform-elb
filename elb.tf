resource "aws_lb" "http_elb" {
  name               = "http-elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${aws_security_group.sec-grp.id}"]
  subnets            = ["${var.aws_subnet}", "${var.aws_subnet2}"]
   tags = {
    Name = "http-elb"
  }
  }
  
resource "aws_lb_target_group" "target-grp" {
  name     = "target-grp"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws_vpc}"
  health_check {
                path = "/healthcheck"
                port = "80"
                protocol = "HTTP"
                healthy_threshold = 2
                unhealthy_threshold = 2
                interval = 5
                timeout = 4
                matcher = "200-308"
  }
}

resource "aws_lb_target_group_attachment" "target1" {
  target_group_arn = "${aws_lb_target_group.target-grp.arn}"
  target_id        = "${aws_instance.linux_vm.id}"
  port             = 80
  }
  
resource "aws_lb_target_group_attachment" "target2" {
  target_group_arn = "${aws_lb_target_group.target-grp.arn}"
  target_id        = "${aws_instance.linux_vm2.id}"
  port             = 80
  }

#resource "aws_lb_target_group_attachment" "target2" {
#  target_group_arn = "${aws_lb_target_group.target-grp.arn}"
#  target_id        = "${aws_instance.win_vm.id}"
#  port             = 80
#  }

resource "aws_lb_listener" "elb_listener" {
  load_balancer_arn = "${aws_lb.http_elb.arn}"
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.target-grp.arn}"
  }
}
