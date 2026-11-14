# harness

에이전트 작업 하네스 모음. 각 폴더는 원래 별도 레포였고 커밋 이력이 보존되어 있다.

| 폴더 | 원래 레포 | 쓰는 법 |
|---|---|---|
| agent-harness/ | agent-harness | Claude Code 플러그인. 아래 설치 참고 |
| own-harness/ | own-harness | Codex 하네스. [own-harness/README.md](own-harness/README.md) |
| pstack-codex/ | pstack-codex | Codex 스킬. [pstack-codex/README.md](pstack-codex/README.md) |
| task-driven-dev/ | task-driven-dev | 작업 기록 방식 문서 |
| claude-code-web-init-script/ | claude-code-web--init-script | Claude Code 웹 세션 초기화 스크립트 |

## agent-harness 설치

이 레포 루트가 Claude Code 플러그인 marketplace(`harness`)다.

```
/plugin marketplace add jadewisemann/harness
/plugin install agent-harness@harness
```
