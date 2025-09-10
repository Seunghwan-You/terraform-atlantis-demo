resource_group_name = "rg-atlantis-dev"
location            = "koreacentral"
#  VM 패스워드는 민감정보이므로 Atlantis에서 변수로 주입합니다.

# 값을 수정하고 PR을 만들어 Atlantis로 테스트해보세요
tags = {
  Environment = "development"
  ManagedBy   = "Terraform-Atlantis"
  Project     = "GitOps-Demo"
  Owner       = "yooshwan"
}



