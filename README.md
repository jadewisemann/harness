# claude-code-web--init-script

Claude Code 웹(claude.ai/code) 샌드박스 초기 세팅 스크립트.

## 하는 일

1. **플러그인 설치** — 각 마켓플레이스 등록 후 설치
   - [fluent-korean](https://github.com/snflkd/fluent-korean) — 자연스러운 한국어 출력 스타일
   - [i-have-adhd](https://github.com/ayghri/i-have-adhd) — action-first 출력 정형
   - [caveman](https://github.com/JuliusBrussee/caveman) — 초압축 커뮤니케이션 모드
2. **skill 배치** — `skills/`를 `~/.claude/skills/`로 복사
   - `agent-work-schema` — 문서 정본 기반 AI 작업 스키마를 프로젝트에 도입하는 skill. 세션에서 `/agent-work-schema` 호출로 사용.

## 사용

Claude Code 웹 환경 설정의 setup script에:

```bash
curl -fsSL https://raw.githubusercontent.com/jadewisemann/claude-code-web--init-script/main/init.sh | bash
```

로컬(git bash 등)에서는 클론 후 `./init.sh`. 여러 번 실행해도 안전(멱등).
