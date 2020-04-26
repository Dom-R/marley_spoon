# Marley Spoon Coding Challenge

## Dependencies

- Ruby (Created with Ruby 2.7.0)
- Docker

## Setting Up
It is recommended to use Bundler to install the required gems.

```bash
gem install bundler
bundle install
```

## Running the Project
This project uses data from Contentful(Content Delivery API).

To run this project, it is *necessary* to supply the following Contentful credentials:
- **Access Token** stored as ENV `CONTENTFUL_ACCESS_TOKEN`
- **Space ID** stored as ENV `CONTENTFUL_SPACE`

You can export them:
```bash
export CONTENTFUL_ACCESS_TOKEN=<Access Token>
export CONTENTFUL_SPACE=<Space ID>
```

or supply them before running the commands below:

```bash
CONTENTFUL_ACCESS_TOKEN=<Access Token> CONTENTFUL_SPACE=<Space ID> command
```

### Local
To run locally, you can use _rack_, _shotgun_, or _docker_.
```bash
bundle exec rackup -p 4567
```
```bash
bundle exec shotgun -p 4567
```
```bash
docker-compose up -d
```

If nothing breaks, you can now access the website at `http://localhost:4567/`.

### Production
A Dockerfile is included to generate an image to be used in a production environment.

## Testing
Tests are implemented in _rspec_. You can run them by executing `bundle execute rspec`. 

### VCR
VCR is used to record HTTP calls to Contentful to avoid interacting with the API when running tests.
Recorded HTTP calls can be found in `spec/cassettes`.

**OBS:** Don't forget to set Contentful credentials when VCR is disabled/ignored/bypassed.
