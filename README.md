# YaVende ruby backend developer test

This repo hosts the skeleton of a tested rails API.
It's meant to be completed by candidates as a leveling test.


## Human requirements

Any candidate capable of solving this test should have the following attributes (in order of importance):

- Basic/intermediate programming skills with Ruby and RoR.
- Learning/googling capabilities, need to find out how to make things work even when not having much or any previous experience with the technhologies or types of programming involved.
- Knowledge of good coding practices, OOP or FP or FP programming patterns and good ol' common (programming?) sense. Generally speaking, the skills needed to write code that can be easily understood and reused/replaced.
- The capability of understanding features and feature requirements and implementing them to detail.
- Testing capabilities: the ability to test code, and also to understand tests before the code is written (TDD).
- Experience building stuff with ruby: complex DB quering, searches, api building, authentication, etc.

## Environment requirements

- Ruby (miminum version: 2.2, recomended: 2.3.1, 2.3.3)
- A db engine. Code comes prepared for PostgreSQL but you may use any other db your heart desires

## Assignment

### Topic
We have users that need to sell their cars (sellers).
We have users that want to buy those cars (buyers).
The candidate must build an appoitment API, where sellers can create appointments whith buyers.

### Requirements

The following endpoints must be created:

- `POST /v1/auth`
  -  accepts parameters `credentials: {email, password}`. Given password matches, returns a JWT token. Else returns an error description with status code 401.
- `POST /v1/appointments`
  - accepts parameteres `appointment: {buyer_id, seller_id, date}`.
  - validates does not overlap other appointments belonging to the involved parts
  - 30min before the time of the appointment will send an email notification to the involved users
  - requires authentication
- `PUT /v1/appointments/:id/confirm`
  - confirms the appointment.
  - only the car owner (the buyer) should be able to call this action
  - requires authentication
- `PUT /v1/appointments/:id/cancel`
  - cancels the appointment
  - the buyer and the seller can call this action, but not other user.
  - requires authentication

Aditionally, this points must be enforced:

- Require user authentication when proper. In case of error, use status 401.
- Require user authorization of actions (checking whether the authenticated user is able to perform the action). In case of error use status code 403
- Validate. In case of error use status code 422.
- Test. The skeleton comes tested so you only have to write code to make the light green.
For simplicity's sake, this tests were written under the assumption that you will use certain technologies and api routes.
You may decide not to use `Sidekiq` for background jobs, or may want to ditch `ActionMailer` for something else.
If that's case, modify the tests accordingly.

Remember, ***tests must pass in order to consider this test solved***.

### Recommended gems
The app comes bundled with some default gems.
These however are merely recommendations.
You are free to remove and add any gem as you see fit for the completion of the task.

- [grape](https://github.com/ruby-grape/grape), for api developing
- [grape-entity](https://github.com/ruby-grape/grape-entity), for resource presentation. Spiritually similar to Draper or ActiveRecordSerializers.
- [jwt](https://github.com/jwt/ruby-jwt), for jwt token management
- [sidekiq](https://github.com/mperham/sidekiq) for background jobs
- [actionmailer](https://github.com/rails/rails/tree/master/actionmailer), rails' default for mailing.
- [rspec-rails](https://github.com/rspec/rspec-rails), for testing
- [factory_girl_rails](https://github.com/thoughtbot/factory_girl_rails) and [faker](https://github.com/stympy/faker), for dummy data generation

### Getting up and runing

For this repo with your own account.

~~~bash
git clone git@github.com:youruser/ruby_backend_developer_test.git
cd ruby_backend_developer_test
bundle
rake db:create db:migrate # You probably will need to tweak config/database.yml
rails s
~~~
Running tests:
~~~bash
rake spec
# or
rspec
~~~
Solve stuff. Once you are done, push all to master and notify us. Good luck, have fun.

## Contributing
Pull requests and issues are welcome.
We'd love to see better ways to test the points described in [Human requirements](#human-requirements), while remaining short and easy to complete by a potencial candidate.
