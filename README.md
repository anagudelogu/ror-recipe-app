![](https://img.shields.io/badge/Microverse-blueviolet)

# Recipe app

This Recipe app keeps track of all your recipes, ingredients, and inventory. It will allow you to save ingredients, keep track of what you have, create recipes, and generate a shopping list based on what you have and what you are missing from all your recipes. Also, since sharing recipes is an important part of cooking, the app should allow you to make them public so anyone can access them.

## Built With

- Ruby
- Rails
- Rspec
- Capybara

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

- You should have ruby installed in your machine, you can follow the steps given by the [official documentation](https://www.ruby-lang.org/en/documentation/installation/).

- You should have a postgres user with superuser permissions. you can refer to the official [postgres documentation](https://www.postgresql.org/docs/current/role-attributes.html#:~:text=To%20create%20a%20new%20database,that%20is%20already%20a%20superuser.&text=A%20role%20must%20be%20explicitly,use%20CREATE%20ROLE%20name%20CREATEDB%20.) to create or update a role.

### Setup

First, you must clone this repository locally running this command:

```
git clone git@github.com:anagudelogu/blog_app.git
```

and navigate to the cloned directory:

```
cd blog_app
```

### Install

Once inside the project directory, you should install all project dependencies:

- Install bundler:

```
gem install bundler
```

- Install project dependencies

```
bundle install
```

### Usage

You can get the app running locally by opening a local server:

```
bin/rails server
```

### Run tests

If you're on a linux-based system, you could run the executable file to run all specs:

```
bin/rspec
```

Windows users have to specify ruby in this case:

```
ruby bin/rspec
```

## Authors

👤 **Andres Agudelo**

- GitHub: [@anagudelogu](https://github.com/anagudelogu)
- Twitter: [@AgudeloAndres\_\_](https://twitter.com/AgudeloAndres__)
- LinkedIn: [Andres Agudelo Guzman](https://linkedin.com/in/aagst)

👤 **Mariana Revilla Lérida**

- GitHub: [@marurevi](https://github.com/marurevi)
- Twitter: [@MaruRevilla](https://twitter.com/MaruRevilla)
- LinkedIn: [Mariana-Revilla-Lérida](https://linkedin.com/in/mariana-revilla-l%C3%A9rida-a12aba143)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](https://github.com/anagudelogu/ror-recipe-app/issues).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc

## 📝 License

This project is [MIT](./LICENSE) licensed.
