# Ruby test

This application aims to manage a collection of offers providing an administrator panel to create and delete offers, and a home page listing all enabled offers.

## Usage

To execute locally, just run the rails server:
```
rails s
```

It is going to provide two routes:

- `/` - The home page, which lists all available offers (filtering out the disabled ones).
- `/admin` - The administration panel. There you can create a new offer, delete an existing one and enable/disable an existing one.

## Developing

To develop and add new features it is crucial to be safe that you won't break the current code. For that, this project is using RSpec to define and execute unit tests.

With bundler installed (available on RubyGems), just run the RSpec gem under project context:
```
bundle exec rspec
```

Everything should be green and ok!

## Project Structure

This project is separated in the following application layers:

- `Model`: Responsible for handling the data that is going to be exchanged between the other layers. On this case, it just has an Offer entity.
- `Controller`: Handles the requests to the appropriate services. If anything from the request must be parsed before going ahead, here is the place.
- `Service`: Do the operations based on the business rules, using repositories instances to deal with storage. This abstraction must hold mostly of the business rules, which must not be a concern of Controller of Repository layers.
- `Repository`: Responsible for abstracting the storage operations, allowing the service to be decoupled from the specific technology used beneath.

The main objective of this structure is to keep the things as isolated as possible. This way, we can change the repository technology without changing anything in the related service, for instance. The service layer must apply the business rules without concerning with storage specifics. The same way, the controller doesn't need to concern about how the service will do the desired operation.

To do that, each service is receiving the repository implementation as a dependency injection. An advantage of that is for testing, because we can develop tests for the other layers using a different repository implementation.

For instance, services tests can be executed without running an actual database if provided a memory repository implementation instead of actual repository. Because we don't want to leave the actual storage communication out of testing, the repository specs behave like an integration test, touching the actual database.

## Next Steps

- `Caching`: Every request to list the offers is actually going to the database each time. Using caches in the controller is a good way to avoid this unnecessary calls. A common approach is to use the last `updated_at` timestamp as the cache key to know if anything changes. Cache view fragments is very usual too, using a strategy called [russian doll caching](https://guides.rubyonrails.org/caching_with_rails.html#russian-doll-caching) is a good way to achieve that.
- `Background jobs`: If need, an option to execute background jobs (assync) is to use Sidekiq gem. However, it is encouraged to separate this kind of things on another application. This way we can handle separately with web and non-web transactions.
- `Monitoring`: An important part is to monitor our application when its on production environment. Application metrics that is relevant to the business must be sent and stored in another place, so we can get ahead of possible problems and the impact of current deploys. Tools like NewRelic, Kibana and Grafana can help with that.
