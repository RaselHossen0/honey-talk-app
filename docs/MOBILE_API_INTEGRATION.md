# Mobile API Integration

Base URL is configured in `lib/core/network/api_config.dart` (`kApiBaseUrl`). Default: **remote API** (same as admin panel, e.g. `http://217.216.78.43:3000/api/v1`). For local dev or emulator, build with `--dart-define=API_BASE_URL=http://10.0.2.2:3000/api/v1` (Android) or `--dart-define=API_BASE_URL=http://localhost:3000/api/v1` (iOS).

## Integrated (real backend)

| Feature        | API / endpoint              | Mobile usage |
|----------------|-----------------------------|--------------|
| Auth           | `POST /auth/login`, `GET /users/me` | Login flow, profile |
| Settings       | `GET /settings`             | FetchSettingApi |
| Profile (me)   | `GET /users/me`             | FetchLoginUserProfileApi |
| Gifts          | `GET /gifts/categories`, `GET /gifts/category/:id` | GiftCategory, category-wise gifts |
| User coin      | `GET /wallets/balance`     | FetchUserCoinApi |
| Coin plans     | `GET /payments/coin-plans`  | FetchCoinPlanApi (recharge page) |
| Wealth levels  | `GET /wealth-levels`       | FetchWealthLevelApi (level rules from backend) |
| Report reasons | `GET /report/reasons`      | FetchReportReasonApi |
| Help           | `POST /help`               | HelpApi (complaint/contact/image) |
| Tasks          | `GET /tasks`               | FetchTaskApi (dailyTasks from API; countdown/bonuses use defaults) |

## Also integrated
| Feature           | API / endpoint                | Mobile usage |
|-------------------|-------------------------------|--------------|
| Other user profile| `GET /users/:id`              | FetchOtherUserProfileApi, FetchOtherUserProfileInfoApi |
| User-wise posts   | `GET /posts/user/:userId`     | FetchUserWisePostApi (common + preview) |
| User-wise videos  | `GET /videos/user/:userId`    | FetchUserWiseVideoApi (common + preview) |
| Gift gallery      | `GET /gifts/gallery/:userId`  | FetchGiftGalleryApi |
| Live list         | `GET /live`                   | FetchLiveFemaleApi, FetchLiveUserApi (stream/message) |
| Store items       | `GET /store/items`            | FetchAllFramesApi (store page) |
| Emoji             | `GET /emoji`                  | FetchEmojiApi |
| Report submit     | `POST /report`                | SubmitReportApi (report bottom sheet) |

## Not yet wired / backend TBD
- **Messages / chat:** Backend endpoints TBD; wire when ready.
- **Logout:** Call `Database.onClearAccessToken()` on logout (and Firebase/Google sign out); optional refresh via `POST /auth/refresh` and `onSetAccessToken`.

## Conventions

- Backend uses Bearer JWT; mobile stores it in `Database.accessToken`; `ApiClient` sends it when present.
- Backend often returns `id`; mobile models often expect `_id` — mapping is done in API layer (e.g. `m['_id'] ??= m['id']`) before `fromJson`.
