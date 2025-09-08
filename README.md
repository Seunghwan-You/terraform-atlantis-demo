# 아틀란티스를 이용한 GitOps 구성 가이드 (Azure + Terraform)

간단한 Azure 리소스(VNet/Subnet + Linux VM)를 Terraform으로 배포하고, Atlantis로 GitOps 워크플로우를 구성하는 최소 예제입니다.

## 구조
```
environments/
  dev|prod: env별 main.tf, variables.tf, terraform.tfvars
modules/
  networking: VNet/Subnet
  vm: Linux VM + Public IP
atlantis.yaml: 프로젝트/워크플로우 설정
```

## 주의 사항
 - 첫 사용 전 `environments/dev|prod/main.tf`의 backend 값 중
   `resource_group_name`/`storage_account_name` 플레이스홀더를 실제 값으로 교체하세요.

## 보안/레포지토리 주의
- 이 가이드는 실습 편의를 위해 `environments/dev|prod/terraform.tfvars`를 레포지토리에 포함합니다.
- **GitHub 무료 계정 사용자의 경우**: Private Repository에서는 브랜치 보호 규칙 제한으로 Atlantis 테스트가 어렵습니다. 따라서 Public Repository를 사용하시기 바랍니다.
- **Public 저장소 사용 시 참고**:  
  - 보안상 `terraform.tfvars`에 VM 패스워드 변수를 정의하지 않습니다. 대신 Atlantis에서 `TF_VAR_admin_password` 환경변수를 이용해 비밀번호를 주입합니다. (가이드 참고)
  
## Atlantis 사용 개요
- PR 생성 시 자동으로 `init/plan` 실행 (atlantis.yaml의 `autoplan`)
- 승인 후 `atlantis apply`로 반영

백엔드가 설정되어 있으므로, Atlantis 서버에서 Azure 권한(Managed Identity 또는 `ARM_*` env)과 tfstate 스토리지가 접근 가능한 네트워크가 필요합니다.

## 진행 방법
- 환경별 `main.tf`의 리소스/모듈 블록은 주석 처리되어 있습니다. 가이드를 따라 단계별로 주석을 해제하고 Pull Request를 만들면 Atlantis가 `plan`을 수행합니다. 승인 후 `atlantis apply`로 실제 배포를 진행하세요.
- 상세한 단계별 설명은 블로그 포스트를 참고하세요: https://skyops.dev

## 참고
- 기본 리전: `koreacentral`
- CIDR는 dev/prod에 서로 다르게 지정됨.


