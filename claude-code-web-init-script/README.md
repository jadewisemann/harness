# claude-code-web--init-script

Claude Code 웹(claude.ai/code) 클라우드 세션 초기 세팅 스크립트.

## 하는 일

1. **플러그인 설치** — 각 마켓플레이스 등록 후 설치
   - [fluent-korean](https://github.com/snflkd/fluent-korean) — 자연스러운 한국어 출력 스타일
   - [i-have-adhd](https://github.com/ayghri/i-have-adhd) — action-first 출력 정형
   - [caveman](https://github.com/JuliusBrussee/caveman) — 초압축 커뮤니케이션 모드
2. **skill 배치** — `skills/`를 `~/.claude/skills/`로 복사
   - `agent-work-schema` — 문서 정본 기반 AI 작업 스키마를 프로젝트에 도입하는 skill. 세션에서 `/agent-work-schema` 호출로 사용.

## 사용법 — Claude Code 웹에 적용

클라우드 세션은 **환경(Cloud environment)** 설정의 Setup script로 초기화된다.

1. [claude.ai/code](https://claude.ai/code) 접속 → 세션 생성 화면에서 환경 선택 드롭다운 → **환경 설정(environment settings) 다이얼로그** 열기
2. **Network access**가 기본값 **Trusted**인지 확인 — GitHub·claude CLI 접근에 필요 (None이면 설치 실패)
3. **Setup script** 필드에 아래 한 줄 입력 후 저장:

```bash
curl -fsSL https://raw.githubusercontent.com/jadewisemann/harness/main/claude-code-web-init-script/init.sh | bash
```

4. 새 세션을 시작하면 Claude Code가 뜨기 전에 스크립트가 실행된다 (Ubuntu 24.04, root).

### 동작 특성 (공식 제약)

- **최초 1회만 실행** — 완료 후 파일시스템 스냅샷이 캐시되어 이후 세션은 설치된 상태로 바로 시작. 캐시는 setup script를 수정하거나 약 7일 경과 시 재빌드.
- **exit 0 필수** — 스크립트가 non-zero로 끝나면 세션 시작 자체가 실패. init.sh는 개별 단계 실패를 경고로만 처리하고 항상 0으로 끝나도록 작성됨.
- **5분 내 종료** — 현재 스크립트는 clone 몇 개 수준이라 여유 있음.

### 대안: 레포별 플러그인 선언

skill 없이 플러그인만 필요하면, 각 프로젝트 레포의 `.claude/settings.json`에 선언하는 게 공식 지원 경로다 (세션 시작 시 자동 설치, setup script 불필요):

```json
{
  "extraKnownMarketplaces": {
    "fluent-korean": { "source": { "source": "github", "repo": "snflkd/fluent-korean" } },
    "i-have-adhd": { "source": { "source": "github", "repo": "ayghri/i-have-adhd" } },
    "caveman": { "source": { "source": "github", "repo": "JuliusBrussee/caveman" } }
  },
  "enabledPlugins": {
    "fluent-korean@fluent-korean": true,
    "i-have-adhd@i-have-adhd": true,
    "caveman@caveman": true
  }
}
```

단, `agent-work-schema` skill은 이 방식으로 배포되지 않으므로 setup script 방식을 권장.

## 로컬 사용

클론 후:

```bash
./init.sh
```

여러 번 실행해도 안전(멱등). Windows는 git bash에서 실행.

## 스키마 도입 흐름

init은 skill **설치**까지만 한다. 실제 문서 체계(AGENTS.md·DESIGN.md·훅) 생성은 대상 프로젝트 세션에서:

```
/agent-work-schema
```

를 호출하면 에이전트가 그 레포를 분석해 스키마를 도입한다.
