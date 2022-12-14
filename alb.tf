resource "aws_lb" "cat-test-alb" {
  name               = "cat-test-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = ["subnet-0b4a62ab0d7002302","subnet-0af5eaf800f63f4a0","subnet-087f98413c34e9761"]

#   enable_deletion_protection = true

#   access_logs {
#     bucket  = aws_s3_bucket.lb_logs.bucket
#     prefix  = "test-lb"
#     enabled = true
#   }

  tags = {
    Environment = "cat-alb"
  }
}

resource "aws_lb_target_group" "cat-tg-jenkins" {
  name     = "jenkins"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-jenkins" {
  target_group_arn = aws_lb_target_group.cat-tg-jenkins.arn
  target_id        = aws_instance.jenkins.id
  port             = 8080
}


resource "aws_lb_target_group" "cat-tg-tomcat" {
  name     = "tomcat"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-tomcat" {
  target_group_arn = aws_lb_target_group.cat-tg-tomcat.arn
  target_id        = aws_instance.tomcat.id
  port             = 8080
}

resource "aws_lb_target_group" "cat-tg-apache" {
  name     = "apache"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-apache" {
  target_group_arn = aws_lb_target_group.cat-tg-apache.arn
  target_id        = aws_instance.apache.id
  port             = 80
}

resource "aws_lb_target_group" "cat-tg-nexus" {
  name     = "tg-nexus"
  port     = 8081
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-nexus" {
  target_group_arn = aws_lb_target_group.cat-tg-nexus.arn
  target_id        = aws_instance.nexus.id
  port             = 8081
}

resource "aws_lb_target_group" "cat-tg-sonarqube" {
  name     = "tg-sonarqube"
  port     = 9000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-sonarqube" {
  target_group_arn = aws_lb_target_group.cat-tg-sonarqube.arn
  target_id        = aws_instance.sonarqube.id
  port             = 9000
}
resource "aws_lb_target_group" "cat-tg-prometheus" {
  name     = "tg-prometheus"
  port     = 9090
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-prometheus" {
  target_group_arn = aws_lb_target_group.cat-tg-prometheus.arn
  target_id        = aws_instance.pg.id
  port             = 9090
}
resource "aws_lb_target_group" "cat-tg-grafana" {
  name     = "tg-grafana"
  port     = 3000
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-grafana" {
  target_group_arn = aws_lb_target_group.cat-tg-grafana.arn
  target_id        = aws_instance.pg.id
  port             = 3000
}
resource "aws_lb_target_group" "cat-tg-node_exporter" {
  name     = "node-exporter"
  port     = 9100
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc1.id
}

resource "aws_lb_target_group_attachment" "cat-tg-attachment-node_exporter" {
  target_group_arn = aws_lb_target_group.cat-tg-node_exporter.arn
  target_id        = aws_instance.node_exporter.id
  port             = 9100
}




resource "aws_lb_listener" "cat-alb-listener" {
  load_balancer_arn = aws_lb.cat-test-alb.arn
  port              = "80"
  protocol          = "HTTP"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-jenkins.arn
  }
}

resource "aws_lb_listener_rule" "cat-jenkins-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
#   priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-jenkins.arn
  }

  condition {
    host_header {
      values = ["jenkins.cat.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "cat-tomcat-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
#   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-tomcat.arn
  }

  condition {
    host_header {
      values = ["tomcat.cat.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "cat-apache-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
#   priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-apache.arn
  }

  condition {
    host_header {
      values = ["apache.cat.quest"]
    }
  }
}

resource "aws_lb_listener_rule" "cat-nexus-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-nexus.arn
  }

  condition {
    host_header {
      values = ["nexus.cat.quest"]
    }
  }
}
resource "aws_lb_listener_rule" "cat-sonarqube-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-sonarqube.arn
  }

  condition {
    host_header {
      values = ["sonarqube.cat.quest"]
    }
  }
}
resource "aws_lb_listener_rule" "cat-prometheus-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-prometheus.arn
  }

  condition {
    host_header {
      values = ["prometheus.cat.quest"]
    }
  }
}
resource "aws_lb_listener_rule" "cat-grafana-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-grafana.arn
  }

  condition {
    host_header {
      values = ["grafana.cat.quest"]
    }
  }
}
resource "aws_lb_listener_rule" "cat-node_exporter-hostbased" {
  listener_arn = aws_lb_listener.cat-alb-listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.cat-tg-node_exporter.arn
  }

  condition {
    host_header {
      values = ["node_exporter.cat.quest"]
    }
  }
}