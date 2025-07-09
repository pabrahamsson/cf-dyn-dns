# Changelog

## [1.6.7](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.6.6...v1.6.7) (2025-07-09)


### Bug Fixes

* **pac:** Add 'latest' tag on release image ([#141](https://github.com/pabrahamsson/cf-dyn-dns/issues/141)) ([4acb64f](https://github.com/pabrahamsson/cf-dyn-dns/commit/4acb64fbee94e8ab16369a99e7c9b3ededd20f30))
* **pac:** Use string for BUILD_EXTRA_ARGS ([#142](https://github.com/pabrahamsson/cf-dyn-dns/issues/142)) ([f221bd5](https://github.com/pabrahamsson/cf-dyn-dns/commit/f221bd59c796c4bb6384615834f23002c4679d61))

## [1.6.6](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.6.5...v1.6.6) (2025-07-09)


### Bug Fixes

* **deps:** update module github.com/miekg/dns to v1.1.67 ([#139](https://github.com/pabrahamsson/cf-dyn-dns/issues/139)) ([c9751a7](https://github.com/pabrahamsson/cf-dyn-dns/commit/c9751a761d30cf2008346d3eb66ce2191839e00e))

## [1.6.5](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.6.4...v1.6.5) (2025-06-30)


### Bug Fixes

* **deps:** update opentelemetry-go monorepo ([#132](https://github.com/pabrahamsson/cf-dyn-dns/issues/132)) ([37c8ac2](https://github.com/pabrahamsson/cf-dyn-dns/commit/37c8ac253e90bc9fc5771db7862fb66c472a3892))

## [1.6.4](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.6.3...v1.6.4) (2025-06-18)


### Bug Fixes

* **cloudflare-go:** Changed cloudflare-go 4.5.0 RecordUpdateParams ([#130](https://github.com/pabrahamsson/cf-dyn-dns/issues/130)) ([3876852](https://github.com/pabrahamsson/cf-dyn-dns/commit/3876852e43554cfd5d4efe5ca38e2714315e76ce))
* **config:** Renovate file pattern regex ([#125](https://github.com/pabrahamsson/cf-dyn-dns/issues/125)) ([96c8108](https://github.com/pabrahamsson/cf-dyn-dns/commit/96c8108b1ff6ad51aa65e4dea60241b588bed01a))
* **pac:** Only run release pipeline on path changes ([#123](https://github.com/pabrahamsson/cf-dyn-dns/issues/123)) ([edb9019](https://github.com/pabrahamsson/cf-dyn-dns/commit/edb90191af0a678eac8bdc34d0d436f56872c9c5))

## [1.6.3](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.6.2...v1.6.3) (2025-06-11)


### Bug Fixes

* **ci:** Use renovate kubernetes manager for pipelines ([#120](https://github.com/pabrahamsson/cf-dyn-dns/issues/120)) ([2f03234](https://github.com/pabrahamsson/cf-dyn-dns/commit/2f03234502895b4bb5f03b46ce6cbd3ed0ecb8b6))

## [1.6.2](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.6.1...v1.6.2) (2025-06-11)


### Bug Fixes

* **pac:** Check PaC for image updates ([#116](https://github.com/pabrahamsson/cf-dyn-dns/issues/116)) ([bc8d5d4](https://github.com/pabrahamsson/cf-dyn-dns/commit/bc8d5d4810811609e54a5fc0d4d999683821f76f))

## [1.6.1](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.6.0...v1.6.1) (2025-06-11)


### Bug Fixes

* **pac:** Add registry push creds ([7fc7fb6](https://github.com/pabrahamsson/cf-dyn-dns/commit/7fc7fb68b38665b21fa93030114b3f7eff0e97ff))
* **pac:** Add registry push creds ([01e8839](https://github.com/pabrahamsson/cf-dyn-dns/commit/01e8839c3a66e060d155730c85ec3994b5d88720))

## [1.6.0](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.5.0...v1.6.0) (2025-06-11)


### Features

* **pac:** Migrate to use Buildah ([65a8df8](https://github.com/pabrahamsson/cf-dyn-dns/commit/65a8df84e5c7f5f2538f890e8f703198dcd1a3f4))
* **pac:** Migrate to use Buildah ([acfbf26](https://github.com/pabrahamsson/cf-dyn-dns/commit/acfbf26ad2438b14adc480a5183447a24f33091c))


### Bug Fixes

* **pac:** Don't use cluster resolver for local tasks ([35e1882](https://github.com/pabrahamsson/cf-dyn-dns/commit/35e1882f02c54e25424ef4fcc1207ec1b39c53e8))
* **pac:** Don't use cluster resolver for local tasks ([3e95e97](https://github.com/pabrahamsson/cf-dyn-dns/commit/3e95e976c409e34b9c5e97651ae47f72509f9d37))

## [1.5.0](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.12...v1.5.0) (2025-06-04)


### Features

* **pac:** Initial migration to PaC ([a53ac6e](https://github.com/pabrahamsson/cf-dyn-dns/commit/a53ac6e3bf15e239c23b4ffdcce3d0818a74a7bd))
* **pac:** Initial migration to PaC ([969fedf](https://github.com/pabrahamsson/cf-dyn-dns/commit/969fedf615e77426f4345ffd5e04d3218a800788))


### Bug Fixes

* **deps:** update module github.com/cloudflare/cloudflare-go/v4 to v4.4.0 ([4517d7e](https://github.com/pabrahamsson/cf-dyn-dns/commit/4517d7e774dd3696e0c7dd1ba296a3540f99c036))
* **deps:** update module github.com/cloudflare/cloudflare-go/v4 to v4.4.0 ([bc0c472](https://github.com/pabrahamsson/cf-dyn-dns/commit/bc0c47247fc50d8b50a4355f153688585f52aeb7))
* **deps:** update opentelemetry-go monorepo ([3289868](https://github.com/pabrahamsson/cf-dyn-dns/commit/32898689c2e08b0a5cf8936019062045c884c26c))
* **deps:** update opentelemetry-go monorepo ([01c362c](https://github.com/pabrahamsson/cf-dyn-dns/commit/01c362cc66c675ede5acb593bf0f7e95f847d873))
* **pac:** Add custom build task ([3c93a30](https://github.com/pabrahamsson/cf-dyn-dns/commit/3c93a304b998d6ae81c0e640ca40f1667c739c46))
* **pac:** Add release-please config ([f049702](https://github.com/pabrahamsson/cf-dyn-dns/commit/f0497026fb38463af742177ea7ed1ce029b233ae))
* **pac:** Add release-please config ([dc9e1df](https://github.com/pabrahamsson/cf-dyn-dns/commit/dc9e1dfcb5fe64739251948152d1044676ac6c1e))
* **pac:** Address build cache permissions ([9cbb910](https://github.com/pabrahamsson/cf-dyn-dns/commit/9cbb910bd968c37a9fe99450a8307250f2ba8242))
* **pac:** Conditional image release ([048132d](https://github.com/pabrahamsson/cf-dyn-dns/commit/048132d315446ebc9800d4fdf89a47908a578b7d))
* **pac:** Fix rootless container build ([b46baf7](https://github.com/pabrahamsson/cf-dyn-dns/commit/b46baf787ccdeeb2f9f5d0677b098d6fd64ed10c))
* **pac:** Use Kaniko ([3e9d05c](https://github.com/pabrahamsson/cf-dyn-dns/commit/3e9d05c4952ec5828a04dad3593b483417f0125d))
* **pac:** Use rootless build ([376c68e](https://github.com/pabrahamsson/cf-dyn-dns/commit/376c68e4ee822fbc11d2f3f2cf7dda2ea7b6d99b))
* **pac:** Use UBI 10 build images ([5ef33da](https://github.com/pabrahamsson/cf-dyn-dns/commit/5ef33da710ab29a8f033858714a5ba7e0928e0e8))
* **tkn:** Add release-please manifest ([10a4a96](https://github.com/pabrahamsson/cf-dyn-dns/commit/10a4a960155a49a26a2f79893957c4128eec9f64))
* **tkn:** Add release-please manifest ([85e8fa2](https://github.com/pabrahamsson/cf-dyn-dns/commit/85e8fa2358fbd3bbd24b44afc49bc25d06cd8060))

## [1.4.12](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.11...v1.4.12) (2025-05-08)


### Bug Fixes

* **deps:** update module github.com/cloudflare/cloudflare-go/v4 to v4.3.0 ([3fb5aa6](https://github.com/pabrahamsson/cf-dyn-dns/commit/3fb5aa6dc3d1b7fd8deb28f2db874016a281b78e))
* **deps:** update module github.com/cloudflare/cloudflare-go/v4 to v4.3.0 ([54c877e](https://github.com/pabrahamsson/cf-dyn-dns/commit/54c877ee140226e69e2a3c205fab7790b3642728))
* **deps:** update module github.com/miekg/dns to v1.1.66 ([99382f8](https://github.com/pabrahamsson/cf-dyn-dns/commit/99382f82ed3a700c3ddf5bab713818f5b1a459d6))
* **deps:** update module github.com/miekg/dns to v1.1.66 ([56e5438](https://github.com/pabrahamsson/cf-dyn-dns/commit/56e54384f93304b64f921352d8013536ee026cc6))

## [1.4.11](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.10...v1.4.11) (2025-04-18)


### Bug Fixes

* **deps:** update module github.com/prometheus/client_golang to v1.22.0 ([a2d98e8](https://github.com/pabrahamsson/cf-dyn-dns/commit/a2d98e8db42c90be8321e181cbf03ce23a47c0a3))
* **deps:** update module github.com/prometheus/client_golang to v1.22.0 ([2a2532f](https://github.com/pabrahamsson/cf-dyn-dns/commit/2a2532f89fdea64ad360aec604c61830e859349f))

## [1.4.10](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.9...v1.4.10) (2025-04-06)


### Bug Fixes

* **deps:** update module github.com/miekg/dns to v1.1.65 ([c950849](https://github.com/pabrahamsson/cf-dyn-dns/commit/c9508493e53d31750707d21835a9d24471bae853))
* **deps:** update module github.com/miekg/dns to v1.1.65 ([51e3334](https://github.com/pabrahamsson/cf-dyn-dns/commit/51e33348c6e0a2dfd9b9768fb914b4cb12d5e694))

## [1.4.9](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.8...v1.4.9) (2025-04-03)


### Bug Fixes

* **deps:** update module github.com/rs/zerolog to v1.34.0 ([670bf57](https://github.com/pabrahamsson/cf-dyn-dns/commit/670bf57612344db26007796634cd6d5e89e09436))
* **deps:** update module github.com/rs/zerolog to v1.34.0 ([a51b098](https://github.com/pabrahamsson/cf-dyn-dns/commit/a51b098d09cc718b1bb939dfd3424f01c86d6f59))

## [1.4.8](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.7...v1.4.8) (2025-03-20)


### Bug Fixes

* **deps:** update module github.com/miekg/dns to v1.1.64 ([4fade64](https://github.com/pabrahamsson/cf-dyn-dns/commit/4fade64fcb7dd7ec0c24b4aeb6313173d85d1d17))
* **deps:** update module github.com/miekg/dns to v1.1.64 ([3fb9c6d](https://github.com/pabrahamsson/cf-dyn-dns/commit/3fb9c6dd08cbba7ba1c946727aaa07eab062561a))

## [1.4.7](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.6...v1.4.7) (2025-03-18)


### Bug Fixes

* **deps:** update module github.com/cloudflare/cloudflare-go/v4 to v4.2.0 ([613c59d](https://github.com/pabrahamsson/cf-dyn-dns/commit/613c59d9e31e69a04e42736bc9c6c4d4b0ac9368))
* **deps:** update module github.com/cloudflare/cloudflare-go/v4 to v4.2.0 ([6e02bf8](https://github.com/pabrahamsson/cf-dyn-dns/commit/6e02bf8074d3175c7b3af6b78ec932d399d1472a))

## [1.4.6](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.5...v1.4.6) (2025-03-12)


### Bug Fixes

* **deps:** update module github.com/prometheus/client_golang to v1.21.1 ([bad9853](https://github.com/pabrahamsson/cf-dyn-dns/commit/bad985345d2014ca6a2e1e63b12ba16a5090380f))
* **deps:** update module github.com/prometheus/client_golang to v1.21.1 ([2306963](https://github.com/pabrahamsson/cf-dyn-dns/commit/2306963508a752f5915013d52461ee4d410e7a37))
* **deps:** update opentelemetry-go monorepo ([f5bc461](https://github.com/pabrahamsson/cf-dyn-dns/commit/f5bc461ef145bfcce79d875308dd1b71b098c069))
* **deps:** update opentelemetry-go monorepo ([63c84a2](https://github.com/pabrahamsson/cf-dyn-dns/commit/63c84a2ae39fccd36b288a8b93e60ce4976af53c))

## [1.4.5](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.4...v1.4.5) (2025-02-20)


### Bug Fixes

* **deps:** update module github.com/prometheus/client_golang to v1.21.0 ([dcdda8b](https://github.com/pabrahamsson/cf-dyn-dns/commit/dcdda8b4816cff7b4cf75c3145599ecb52dcac2c))

## [1.4.4](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.3...v1.4.4) (2025-02-18)


### Bug Fixes

* **deps:** switch to cloudflare-go v4 ([f78bccf](https://github.com/pabrahamsson/cf-dyn-dns/commit/f78bccfecb8146f3209f832a9c96bfc58c924f59))

## [1.4.3](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.2...v1.4.3) (2025-02-18)


### Bug Fixes

* **deps:** update module github.com/cloudflare/cloudflare-go/v3 to v4 ([e65e77a](https://github.com/pabrahamsson/cf-dyn-dns/commit/e65e77aaaca3a6a062db1b1f3c60986bca13f431))
* **deps:** update module github.com/cloudflare/cloudflare-go/v4 to v4.1.0 ([a7b4ead](https://github.com/pabrahamsson/cf-dyn-dns/commit/a7b4eada282408ad77efd8196bd7de0aef08ab70))
* **deps:** update module github.com/miekg/dns to v1.1.63 ([b1f4b53](https://github.com/pabrahamsson/cf-dyn-dns/commit/b1f4b53d50a208c5355a36ea2dce3055feb92db5))

## [1.4.2](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.1...v1.4.2) (2025-01-20)


### Bug Fixes

* **deps:** update opentelemetry-go monorepo ([9b0105a](https://github.com/pabrahamsson/cf-dyn-dns/commit/9b0105a2dd9517504e0fe74a309750dd404733af))

## [1.4.1](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.4.0...v1.4.1) (2025-01-10)


### Bug Fixes

* **deps:** update module github.com/cloudflare/cloudflare-go/v3 to v4 ([0d1ec9e](https://github.com/pabrahamsson/cf-dyn-dns/commit/0d1ec9eb1582d30bd0087eaca0679df57a5e6b8e))

## [1.4.0](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.3.1...v1.4.0) (2024-12-28)


### Features

* **metrics:** Add Histogram for dns lookup and update operations ([cdf2a70](https://github.com/pabrahamsson/cf-dyn-dns/commit/cdf2a70efa15e8d4cb1db84a79c691b1b6d28485))

## [1.3.1](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.3.0...v1.3.1) (2024-12-26)


### Bug Fixes

* Improve data structure(s) ([39545e9](https://github.com/pabrahamsson/cf-dyn-dns/commit/39545e9d6116cc51fbadf838b5e3804a245a441c))

## [1.3.0](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.2.2...v1.3.0) (2024-12-24)


### Features

* Use concurrent DNS lookups ([3cce691](https://github.com/pabrahamsson/cf-dyn-dns/commit/3cce69133c844673bc62882ff22294192414d31d))

## [1.2.2](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.2.1...v1.2.2) (2024-12-23)


### Bug Fixes

* **deps:** update opentelemetry-go monorepo ([976c75a](https://github.com/pabrahamsson/cf-dyn-dns/commit/976c75a0cda720d7051f94351c81229a875f6929))

## [1.2.1](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.2.0...v1.2.1) (2024-11-28)


### Bug Fixes

* **otel:** Set per function failure counters ([9ac676e](https://github.com/pabrahamsson/cf-dyn-dns/commit/9ac676e3c876bd71fe3ce26674a5cbfe984eda67))

## [1.2.0](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.1.0...v1.2.0) (2024-11-27)


### Features

* **otel:** Add inital support for OpenTelemetry ([be03405](https://github.com/pabrahamsson/cf-dyn-dns/commit/be03405f7fd3c4089b772948e28c12cb24b26cee))


### Bug Fixes

* **build:** Fix Containerfile file copying ([3509ff5](https://github.com/pabrahamsson/cf-dyn-dns/commit/3509ff5710918b71497cfca60b8ac14664c3004b))

## [1.1.0](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.0.1...v1.1.0) (2024-11-26)


### Features

* Switch to cloudflare-go v3 ([d712884](https://github.com/pabrahamsson/cf-dyn-dns/commit/d7128848acf60bfad4ff5ddafbccb4036f2b29a3))


### Bug Fixes

* **deps:** update module github.com/cloudflare/cloudflare-go to v0.110.0 ([11a3ac4](https://github.com/pabrahamsson/cf-dyn-dns/commit/11a3ac46cd407080c76fc5a5bf3195d82c5e8dce))

## [1.0.1](https://github.com/pabrahamsson/cf-dyn-dns/compare/v1.0.0...v1.0.1) (2024-07-05)


### Bug Fixes

* Auto accept cosign agreement ([bf507ad](https://github.com/pabrahamsson/cf-dyn-dns/commit/bf507ad7ad8bc529c0c838112a29f4b473b322bc))
* cosign signing ([ae40110](https://github.com/pabrahamsson/cf-dyn-dns/commit/ae401100226791082eecc106ee19f463407ff2c6))
* Use default cosign version ([b4cc204](https://github.com/pabrahamsson/cf-dyn-dns/commit/b4cc2045460516782e6c24c99a6377dd6adb3c94))

## 1.0.0 (2024-07-05)


### Features

* Add Release Please ([ffce520](https://github.com/pabrahamsson/cf-dyn-dns/commit/ffce52074925e6838494667d9bfa92af5c2fc934))
* Initial commit ([46d4bcd](https://github.com/pabrahamsson/cf-dyn-dns/commit/46d4bcdaf7aac164326c9a8716d45eebd2ee11af))


### Bug Fixes

* Typo in release-please.yml ([276eee2](https://github.com/pabrahamsson/cf-dyn-dns/commit/276eee28ab9ea74acd67c477c6d8b0425f864991))
