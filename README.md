
[![test](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/test.yml/badge.svg)](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/test.yml)
[![release](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/release.yml/badge.svg)](https://github.com/solace-iot-team/apim-uc-acme-retail/actions/workflows/release.yml)

# Async API Management Use Case: Acme Retail

## Setup

### Prerequisites
- **node 16**.
- **Solace Cloud Token**.

### Install
```bash
cd sep-import
npm install
```

## Environment

```bash
cd sep-import
# adjust .env as required
vi .env
```

```bash
# export solace cloud token
export CLI_SOLACE_CLOUD_TOKEN={token}
```

## Run

```bash
cd sep-import

# help
npx sep-async-api-importer -h

# check the version
npx sep-async-api-importer -v

# import single spec into custom domain
npx sep-async-api-importer -fp ../specs/central-it/till-system/AcmeRetail-Central-IT-Provider-TillSystem-v1.spec.yml -d acme-retail/test

# with pretty print of output
npx sep-async-api-importer -fp ../specs/central-it/till-system/AcmeRetail-Central-IT-Provider-TillSystem-v1.spec.yml -d acme-retail/test | npx pino-pretty

# import all specs with custom domain
npx sep-async-api-importer -fp ../specs/**/*.spec.yml -d acme-retail/test

```

## Run Tests

```bash
cd sep-import

./test/run.sh

# log file:
cat ./test/logs/run.sh.out

```

## Details

For more details of how this repo is set up and the workflow(s) behind it, see [Details](./Details.md).

---
