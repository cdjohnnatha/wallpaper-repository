# Summer 2020 Developer Intern Challenge

## Table of Contents

<!-- vscode-markdown-toc -->
- 0. [Problem](#Problem)
- 1. [Intro](#Intro)
- 2. [Installation](#Installation)
- 3. [The Challenge](#TheChallenge)
- 4. [Demo Requirements](#DemoRequirements)
- 5. [Goal](#Goal)
- 6. [Application Goals](#Objects)
- 7. [Functionalities](#Functionalities)
- 8. [Makefile](#Makefile)

## 0. <a name='Problem'></a>Problem

The main task it was a simple as "Build an image repository" but it had some ideas to follow:

* SEARCH function
  * from characteristics of the images from text
  * from an image (search for similar images)
* ADD image(s) to the repository
  * one / bulk / enormous amount of images
  * private or public (permissions)
  * secure uploading and stored images
* DELETE image(s)
  * one / bulk / selected / all images
  * Prevent a user deleting images from another user (access control)
  * secure deletion of images
* SELL/BUY images
  * ability to manage inventory
  * set price
  * discounts
  * handle money

I choose to build a mix of it and it turns at a wallpaper-repository

## 1. <a name='Intro'></a>Intro

The wallpaper-repository is a project which started as an image upload. So imagine that people which it has any type of wallpapers such as physical ones or just online they could with create wallpapers as products where they could upload their product image then simulate an idea of store where it is possible to buy other existent products.

### Stack

*Ruby on Rails*
I decided to use *Ruby on Rails* for three reasons:
* It a language very comfortable to work with
* It would be a challenge to develop a new project with a language that I have been not working with
* And the Shopify is one of the largest applications in the world which works with rails.

#### Graphql

It gives a nice flexibility to clients(frontend) ask exactly what they want and also because it saves a huge time if creates a nice documentation which is provided for each query.

The development flow was devided in few initial steps to provide a better idea about the process flow, but it was changed accordling the necessities.

#### Database project

At first moment the project of database it was as bellow.

![picture](public/images/shopify_database_flow.jpeg)

After that the project grow and it became as:

![Final database diagram](public/images/wallpaper_repository_database_flow.png)

That diagram shows you an idea what the project it is at all however, lets do a brief about how the models are organized.

#### User
* **has_many carts** (0..n)
  * It is created one cart per time and it is just created again once the cart status is changed for purchased.
* **has_many :orders** (0..n)
  * An order is created when an user create a purchase, so that order it will have all the items from cart. 
* **has_many :wallpapers** (0..n).
  * A product with an image.
* **has_and_belongs_to_many :roles** (1..n)
  * A user needs roles to create an idea of authorization.

#### Roles
* **has_and_belongs_to_many :users** (0..n)

#### Wallpapers
* **belongs_to :user**
* **has_many :wallpaper_prices**
  * The idea behind of wallpaper_prices was to have a control about when a price is updated, in this way the associated orders it will not be touched or changed. Everytime when its "updated" a price it will be created a new one.

#### Orders




## 1. <a name='Requirements'></a>Requirements
- [Ruby on Rails](https://rubyonrails.org/)
<!-- - [Docker](https://www.docker.com/) -->

## 2. <a name='Installation'></a>Installation

### **Note:**

At root directory it has a file called .env.prod.sample, there are variables used by the entire application so you have to change accordling your setup, then create a file called one as the same of the enviroment used.

for example: **.env.prod** or **.env.development** (based on the eviroment used to run the project).

### **Note 2:**

It is necessary to generate a secret key and update the value of SECRET_KEY_BASE.

* To generate the secret key you have to use a rails command find bellow, after that copy the key generated to SECRET_KEY_BASE at your .env file.

```
rails  secret
```


* <a name='RailsInstall'></a>Ruby on rails
  It is possible to use all the rails commands.
  * Install [postgresdb](https://www.postgresql.org/download/) 
  * [Altair](https://altair.sirmuel.design/)
  
  <!-- or use docker to run the postgres using 'make build_postgresdb'** -->
  ```bash
    bundle install
    rails db:create
    rails db:migrate
    rails db:seed
    rails s
  ```

## 4. <a name='DemoRequirements'></a>Demo requirements

At first sign I though in use to upload files Base64 that it would be accepted by graphql but I found a gem for it called [Apollo-upload-server-ruby](https://github.com/jetruby/apollo_upload_server-ruby) where with that I could integrate the multipart-form data which is faster than base64, but the problem it was **How to upload binary data in graphql ?** because until then I just used **graphiql**.

I started to search and I found a really nice GraphQL Client IDE which it helps me a lot on that journey, it is called [Altair](https://altair.sirmuel.design/), thanks a lot for it.

To upload a file at wallpaper-repository you can follow that tutorial from [working-with-file-uploads-using-altair-graphql](https://sirmuel.design/working-with-file-uploads-using-altair-graphql-d2f86dc8261f) or if you are just lazy as me just take a look at the print bellow haha.

![Print using Altair to upload a image file in graphql](public/images/upload_image_altair.png)

## 5. <a name='Goal'></a>Goal

The goal is build a backend api using graphql for a fuctional upload repository. The project idea is create a simple ecommerce to sell wallpaper and to make it possible it will be necessary to follow some requirements. 

- 1. Users with differents roles, one who will manage their image uploads and others who wants to buy them.
- 2. Wallappers should belongs to one user and them are the only one who will be allowed to make changes.
- 3. It will be possible to sell wallpapers for someonelse.
- 4. To sell wallpappers it needs to create an order to process the information.
- 5. To find wallpappers the system must provide filters:
    - 5.1. by description.
    - 5.2. by meta
    - 5.3. by category (each wallpaper can has more than one category.) 


## 6. <a name='Application Goals'></a>Application Goals

* Note: The main side goal is to make tests for all resources of application * 

I divided the development as followed:
- 0. Setup the basic libraries.
- 1. Create users.
- 2. Create authentication with roles.
- 3. Create Image object to upload them.
- 4. Create way to resize image keep maximum quality to save storage space.
- 5. Create Categories.
- 6. Create Order.


## 6. <a name='Makefile'></a>MakeFile

Commands            | Action                                                     |
---                 | ---                                                        |
run                 | Run application outside container using rails              |
build_postgresdb    | Start a postgresdb in container (Just if is not installed) |
createdb            | Create database |

--- 

## 7. <a name='Resources'></a>Resources

1. [Graphql ruby](https://graphql-ruby.org/)
2. [Graphql multipart request spec](https://github.com/jaydenseric/graphql-multipart-request-spec) 
3. [Apollo upload server ruby](https://github.com/jetruby/apollo_upload_server-ruby)
4. [Basic graphql authentication](https://www.howtographql.com/graphql-ruby/4-authentication/)
5. [Basic graphql authentication](https://evilmartians.com/chronicles/graphql-on-rails-2-updating-the-data)
6. [Direct uploads](https://evilmartians.com/chronicles/active-storage-meets-graphql-direct-uploads)
7. [Handling file upload using ruby on rails 5](https://www.pluralsight.com/guides/handling-file-upload-using-ruby-on-rails-5-api) 
8. [Upload images with graphql/authentication](https://rubygarage.org/blog/graphql-and-trailblazer-tutorial-part-2#article_title_5) 
9. [Upload image with gem Carrierwave](https://github.com/carrierwaveuploader/carrierwave)
10. [Carrierwave frames](https://www.rubydoc.info/gems/carrierwave/frames) 
11. [Testing graphql mutations](https://selleo.com/blog/testing-graphql-mutations-in-ruby-on-rails-with-rspec) 
12. [Pundit Policies](https://www.rubydoc.info/gems/pundit#Policies)
13. [Authorization with Pundit](https://medium.com/@NickPoorman/graphql-ruby-and-authorization-with-pundit-3d8d2102533d)
14. [Preventing tranversal attacks in your graphql api](https://blog.morethancode.dev/preventing-traversal-attacks-in-your-graphql-api/) 
15. [Create user roles](https://github.com/RolifyCommunity/rolify/)
16. [Secure images](https://github.com/carrierwaveuploader/carrierwave/wiki/how-to:-secure-upload)
17. [Graphql error handling with graphql ruby](https://dev.to/masakazutakewaka/graphql-error-handling-with-graphql-ruby-58j8)
