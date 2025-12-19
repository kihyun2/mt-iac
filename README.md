# CookRep 인프라 (Terraform)

이 저장소는 AWS 인프라를 Terraform으로 관리하는 간단한 구성 예시입니다. 로컬에 두 개의 주요 폴더(`state/`와 `work/`)가 있으며, 각 폴더에 Terraform 구성과 상태 파일이 존재합니다.

**목적**
- 인프라 리소스(예: VPC, 서브넷, 보안 그룹, EC2, EBS 등)를 정의하고 관리하기 위한 Terraform 구성 제공
- 로컬 상태 파일을 통해 학습/테스트용으로 사용 가능

**주의**: 현재 저장소에는 로컬 상태 파일(`terraform.tfstate`)이 포함되어 있습니다. 팀 환경에서는 원격 상태 백엔드(S3 + DynamoDB 등)를 사용하는 것이 안전합니다.

## 디렉터리 구조

- `state/` : 여러 Terraform 리소스의 상태 파일(`terraform.tfstate`, `terraform.tfstate.backup`)과 `ebs.tf` 등이 존재합니다.
- `work/`  : VPC, 서브넷, 라우팅, 보안 그룹, EC2 관련 Terraform 구성 파일들이 있습니다 (`vpc.tf`, `subnet-01.tf`, `sg.tf`, `private-sg.tf`, `igw.tf`, `rt.tf`, `ec.tf`, `main.tf` 등)와 로컬 상태 파일.

예:

```
c:\iac_cookrep\cookrep
├─ state\
│  ├─ ebs.tf
│  ├─ terraform.tfstate
│  └─ terraform.tfstate.backup
└─ work\
   ├─ main.tf
   ├─ vpc.tf
   ├─ subnet-01.tf
   ├─ sg.tf
   ├─ private-sg.tf
   ├─ rt.tf
   ├─ igw.tf
   ├─ ec.tf
   ├─ terraform.tfstate
   └─ terraform.tfstate.backup
```

## 각 파일(요약)
- `vpc.tf`: VPC 생성 정의
- `subnet-01.tf`: 서브넷 정의
- `igw.tf`: 인터넷 게이트웨이
- `rt.tf`: 라우팅 테이블과 라우트
- `sg.tf` / `private-sg.tf`: 보안 그룹 규칙
- `ec.tf`: EC2 인스턴스 관련 리소스
- `ebs.tf`: EBS 볼륨 관련 (state/ 폴더에 위치)
- `main.tf`: 경우에 따라 모듈 호출 또는 공통 설정 포함

> 실제 리소스와 변수 정의는 각 `.tf` 파일을 열어 확인하세요.

## 전제 조건
- Terraform(권장 최신 버전) 설치: https://developer.hashicorp.com/terraform
- AWS 계정 및 IAM 사용자/자격증명
- (선택) AWS CLI 설치 및 구성

Windows `cmd.exe`에서 환경 변수로 AWS 자격증명 설정 예:

```cmd
set AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY_ID
set AWS_SECRET_ACCESS_KEY=YOUR_SECRET_ACCESS_KEY
set AWS_DEFAULT_REGION=ap-northeast-2
```

또는 AWS CLI를 사용하여 구성:

```cmd
aws configure
```

## 빠른 시작 (work/ 디렉터리 예시)

1) `cmd`에서 `work` 디렉터리로 이동

```cmd
cd c:\iac_cookrep\cookrep\work
```

2) Terraform 초기화

```cmd
terraform init
```

3) 계획 생성

```cmd
terraform plan -out=tfplan
```

4) 적용

```cmd
terraform apply "tfplan"
```

5) 삭제(테스트용 리소스 제거)

```cmd
terraform destroy
```

## 로컬 상태 파일 관련 주의사항
- 저장소에 `.tfstate` 파일이 포함되어 있으므로 민감 정보(예: 퍼블릭 IP, 리소스 아이디 등)가 노출될 수 있습니다. 실제 사용 시에는 `.gitignore`에 추가하거나 원격 백엔드를 사용하세요.
- 같은 인프라를 여러 곳에서 동시에 조작하지 마십시오 — 상태 충돌 위험이 있습니다. 팀에서는 S3 원격 상태와 락(DynamoDB)을 권장합니다.

## 변경 시 권장 워크플로우
1. 로컬에서 파일을 수정하기 전에 `terraform plan`으로 영향 범위를 확인합니다.
2. 변경을 적용하기 전 민감한 값(키 등)은 `terraform.tfvars`나 환경변수로 주입하고 깃에는 커밋하지 마세요.
3. 팀 작업 시 원격 상태 사용을 설정하세요.

## 문제 해결 팁
- 자격증명 오류: 환경 변수가 올바른지 또는 `aws configure`로 설정했는지 확인
- 상태 파일 불일치: `terraform refresh` 또는 필요 시 수동 백업 후 복원
- 모듈/프로바이더 버전 문제: `terraform init -upgrade` 시도

## 다음 단계 제안
- 원격 상태(S3 + DynamoDB)로 마이그레이션
- 변수화(variables.tf) 및 `terraform.tfvars.example` 추가
- CI 파이프라인(예: GitHub Actions)으로 `plan`/`apply` 자동화

---
파일 위치: `c:\iac_cookrep\cookrep\README.md`

필요하시면 제가 원격 상태 구성 예제나 `variables.tf` / `tfvars` 템플릿을 추가해 드리겠습니다.
# mt-iac
# mt-iac

```
mt-iac
├─ eks
│  ├─ .terraform.lock.hcl
│  ├─ access-entry.tf
│  ├─ alb-policy.json
│  ├─ bastion-ec2.tf
│  ├─ data.tf
│  ├─ helm-alb.tf
│  ├─ helm-metric.tf
│  ├─ iam.tf
│  ├─ irsa-alb.tf
│  ├─ oidc.tf
│  ├─ provider.tf
│  ├─ sa-alb.tf
│  └─ values
│     ├─ alb-controller.yaml
│     └─ metrics-server.yaml
├─ README.md
├─ state
│  ├─ .terraform.lock.hcl
│  ├─ ebs.tf
│  └─ provider.tf
└─ work
   ├─ .terraform.lock.hcl
   ├─ ec.tf
   ├─ eks-subnet.tf
   ├─ eks.tf
   ├─ igw.tf
   ├─ main.tf
   ├─ nat.tf
   ├─ nodegroup.tf
   ├─ output.tf
   ├─ private-sg.tf
   ├─ provider.tf
   ├─ rt.tf
   ├─ sg.tf
   ├─ subnet-01.tf
   └─ vpc.tf

```