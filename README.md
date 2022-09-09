
[![test](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/test.yml/badge.svg)](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/test.yml)
[![release](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/release.yml/badge.svg)](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/release.yml)

# Async API Management Use Case: Acme Retail

## Setup

### Prerequisites
- **node 16**.
- **Solace Cloud Token**.

### Install
```bash
cd ep-import
npm install
```

## Environment

```bash
cd ep-import

# help
npx ep-async-api-importer -h

# adjust .env as required
vi .env
```

```bash
# export solace cloud token
export CLI_SOLACE_CLOUD_TOKEN={token}
```

## Run

```bash
cd ep-import

# import single spec into custom domain
npx ep-async-api-importer -fp '../specs/central-it/till-system/AcmeRetail-Central-IT-Provider-TillSystem-v1.spec.yml -d acme-retail/test'

# import all specs with custom domain
npx ep-async-api-importer -fp '../specs/**/*.spec.yml' -d acme-retail/test

# import all specs into their respective domains
npx ep-async-api-importer -fp '../specs/**/*.spec.yml'

```

## Run Tests

```bash
cd ep-import

./test/run.sh

# log file:
cat ./test/tmp/logs/run.sh.out

```

## Details

For more details of how this repo is set up and the workflow(s) behind it, see [Details](./Details.md).

---
