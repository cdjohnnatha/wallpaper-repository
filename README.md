# Summer 2020 Developer Intern Challenge

## Table of Contents

<!-- vscode-markdown-toc -->
- 0. [Intro](#Intro)
- 1. [Requirements](#Requirements)
- 2. [Installation](#Installation)
- 3. [The Challenge](#TheChallenge)
- 4. [Demo Requirements](#DemoRequirements)
- 5. [Goal](#Goal)
- 6. [Application Goals](#Objects)
- 7. [Functionalities](#Functionalities)
- 8. [Makefile](#Makefile)

## 0. <a name='Intro'></a>Intro

The idea of this project it is to build an image repository furthermore I have an idea to create a wallpaper store which an user could upload their images and sell it.

I devided the development process in steps for this way to have a better idea about the process flow.

The first part it was related to the database flow:

![picture](public/images/shopify_database_flow.jpeg)

## 1. <a name='Requirements'></a>Requirements
- [Ruby on Rails](https://rubyonrails.org/)
- [Docker](https://www.docker.com/)

## 2. <a name='Installation'></a>Installation

## 3. <a name='TheChallenge'></a>The Challenge

The task is pretty much to build an image repository. A copy of official document it can be found at:
https://docs.google.com/document/d/1I6HwLUedDFFNvgzqHYm2vl3Pmm7VaZnjj3sW_9zLqkM/edit?usp=sharing

There are sugestions about what to do, I took some of them and I will join in a product where I will explain at my goals.

## 4. <a name='DemoRequirements'></a>Demo requirements

* **All of the functionality of your API should be documented so we know what it does, and how to interact with it.**

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

I devided the development as followed:
- 0. Setup the basic libraries.
- 1. Create users.
- 2. Create authentication with roles.
- 3. Create Image object to upload them.
- 4. Create way to resize image keep maximum quality to save storage space.
- 5. Create Categories.
- 6. Create Order.
