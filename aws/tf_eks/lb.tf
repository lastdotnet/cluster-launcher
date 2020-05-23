//resource "kubernetes_namespace" "gitlab" {
//  count = var.gitlab_enabled ? 1 : 0
//  metadata {
//    name = "gitlab"
//  }
//}

//resource "helm_release" "gitlab_postgres" {
//  name       = "postgres"
//  repository = "https://charts.bitnami.com/bitnami"
//  chart      = "postgresql"
//  version    = "8.9.6"
//  namespace  = kubernetes_namespace.gitlab[0].id
//  values     = [file("values/postgres_values.yaml")]
//}

resource "aws_alb" "lb_gitlab" {
  name                             = "${var.cluster_name}-gitlab-lb"
  load_balancer_type               = "network"
  internal                         = false
  enable_cross_zone_load_balancing = true
  subnets                          = module.vpc.public_subnets
  enable_deletion_protection       = false
  idle_timeout                     = 30
  tags                             = var.tags
}

//resource "aws_alb_target_group" "lb_gitlab_http" {
//  name                 = "${local.cluster_name}-gitlab-ingress-http"
//  port                 = var.traefik_service_http_port
//  protocol             = "TCP"
//  vpc_id               = data.terraform_remote_state.eks.outputs.vpc_id
//  deregistration_delay = 30
//  proxy_protocol_v2    = false
//
//  tags = var.tags
//}

//resource "aws_autoscaling_attachment" "lb_gitlab_http" {
//  autoscaling_group_name = data.terraform_remote_state.eks.outputs.cluster_main_node_group_asg
//  alb_target_group_arn   = aws_alb_target_group.lb_gitlab_http.arn
//}

//resource "aws_alb_listener" "lb_gitlab_http" {
//  load_balancer_arn = aws_alb.lb_gitlab.arn
//  port              = 80
//  protocol          = "TCP"
//
//  default_action {
//    target_group_arn = aws_alb_target_group.lb_gitlab_http.arn
//    type             = "forward"
//  }
//}

//resource "aws_security_group_rule" "worker_gitlab_ssh" {
//  security_group_id = data.terraform_remote_state.eks.outputs.cluster_primary_security_group_id
//  from_port         = var.ssh_node_port
//  to_port           = var.ssh_node_port
//  protocol          = "TCP"
//  cidr_blocks       = ["0.0.0.0/0"]
//  type              = "ingress"
//}

output "lb_gitlab_endpoint" {
  value = aws_alb.lb_gitlab.dns_name
}