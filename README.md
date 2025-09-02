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

## 사전 준비
- Azure CLI 로그인: `az login`
- (옵션) SSH 키 대신 비밀번호를 사용하도록 기본 설정됨
 - 첫 사용 전 `environments/dev|prod/main.tf`의 backend 값 중
   `resource_group_name`/`storage_account_name` 플레이스홀더를 실제 값으로 교체하세요.

## 로컬에서 빠른 테스트
```powershell
cd environments/dev
terraform init
terraform plan -out tfplan
terraform apply tfplan
```

출력 `public_ip`를 통해 VM 접속:
```powershell
ssh azureuser@<public_ip>
# 또는 Windows RDP 아님. 이 예제는 Linux VM이므로 SSH이며,
# 비밀번호 인증이 활성화되어 있습니다.
```

정리:
```powershell
terraform destroy -auto-approve
```

## Atlantis 사용 개요
- PR 생성 시 자동으로 `init/plan` 실행 (atlantis.yaml의 `autoplan`)
- 승인 후 `atlantis apply`로 반영

백엔드가 설정되어 있으므로, Atlantis 워커에 Azure 권한(Managed Identity 또는 `ARM_*` env)과 tfstate 스토리지가 접근 가능한 네트워크가 필요합니다.

필요시 서버 측 Atlantis에서 Azure 자격증명(Managed Identity 또는 `ARM_*` env)을 설정하세요.

## 참고
- 기본 리전: `koreacentral`
- CIDR는 dev/prod에 서로 다르게 지정됨


