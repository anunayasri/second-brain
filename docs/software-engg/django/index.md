# Django Web Framework

> Tagline: The web framework for perfectionists with deadlines.

Django is an opinionated, batteries included fullstack web-framework in python language. As the tagline
says, it is designed for rapid development of web application.

**What does it mean?**

Consider a mordern web application, say a _news publishing website_. What do you need for 
this to work for news publishers and readers.

App Features -

1. Readers & Publishers can _login_ to the website. _Login/Logout System_
1. Readers can read (only) the published articles.  _Role base permissions_
1. Publishers can create articles - first in draft mode, which are hidden from readers 
    and subsequently publish those articles, which then the users can read. _Role base permissions_
1. Readers can interact with articles eg like, comment. _Social Interaction_
1. Readers should be able to register on the website, may be throught multiple ways like
    filling in a form, Google Sign In, Twitter Sign In, etc. _OAuth Integration_
1. An administration portal where _site admins_ can onboard publishers, administers users(readers) like
    activate/deactivate user, assign roles to different publishers(writer vs editor). _Admin Portal_
1. User communication via Email/SMS: Verification on signup etc. _Email Integration_
1. Secure interaction with website ie HTTPS, login session management, CSRF, XSS, SQL Injection, etc. _Security_
1. Public(home page) and private pages(update user password). _Authentication & Authorization_

Technical Features -

1. A frontend framework to render the dynamic html page ie make a page to
   display a list of latest articles. Newly published articles should be listed
   in the page.
1. The frontend framework will also need to render the CSS and JS files.
1. If you want to use frontend framework like React the backend framework
   should be able to return json/xml payload.
1. The framework should implement the HTTP 1.1 protocol.
1. Need a way to read & write data to datastore eg. an RDBMS server.

**Django gives you the above listed technical features. It also enables to
implement the app features with ease** How?

First, lets understand what the definition of _Django_ mean.

1. _Web-framework_: A software that understands HTTP protocol(specifically
   version `1.1`) ie can accepts requests and send responses.

1. _Fullstack web-framework_: A web-framework that enables writing client-side
   code(HTML, CSS, JS that run of browser) and server-side code(eg read data
   from datastore and send it to render on the browser)

1. _Opinionated_: Django has strong opinions on how to do things - how to
   arrange files & folders, where to put html, css, js files, where to put
   configs, how to write DB models and run data migrations.

1. _Batteries included_: Django comes with tools(batteries) to power multiple
   common use cases. Eg. a User Management System, an Admin Portal, an ORM, a
   template system to render dynamic HTML pages, cache framework,
   authentication system, etc

1. _Pluggable_: Third-party libraries for common usecases can be easily
   integrated with minimal code. Eg. OAuth(Google signin) Integration.

1. _Scalable_: Django is built using a _shared-nothing architecture_ which
   simply means that you can independently scale the different layers -
   database servers, caching servers or web/application servers.

You can explore the projects build using Django at [builtwithdjango.com](https://builtwithdjango.com/projects/)

---

[Django official documentation](https://docs.djangoproject.com/en/5.1/) is
fabulous. You can start learning from [the official
tutorial](https://docs.djangoproject.com/en/5.1/intro/tutorial01/)

_Django version is `5.1` at the time of writing this doc_

Django docs are organized in a helpful way. There are 4 sections. You can visit them as per your usecase.

1. [Tutorial](https://docs.djangoproject.com/en/5.1/intro/): Steps to create a
   sample web app. Ideal for devs new to Django.
2. [Topic Guides](https://docs.djangoproject.com/en/5.1/topics/): Discuss key
   topics and concepts at a fairly high level and provide useful background
   information and explanation.
3. [Reference Guides](https://docs.djangoproject.com/en/5.1/ref/): Technical
   reference for APIs and Django architecture.
4. [How-to Guides](https://docs.djangoproject.com/en/5.1/howto/): Recipes for
   key problems and use-cases. They are more advanced than tutorials and assume
some knowledge of how Django works.
