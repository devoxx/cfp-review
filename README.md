#Setup global env

- Install [nodejs] [1]
 - It comes with [npm] [2]
- Have a look to [yeoman] [3]: it helps to scallfold an angular project with best practices
- [sudo] npm install -g yo grunt-cli bower generator-angular generator-karma


#Setup project env
- go to a project
- npm install && bower install
 - *npm install* is configured with **package.json** and generates the directory **node_modules**
 - *bower* is configured with **component.json** or **bower.json** and generates the directory **app/components**

##Starts your application##

- grunt server
 - *grunt* is configured with **Gruntfile.js**

##Build your app##

 - grunt

##Update your project's dependencies##
- bower update
 - it update **app/components** directory

##Update your project's build dependencies##
- npm update
 - it update **node_modules** directory

##Support##
- [Best practices] [4]












[1]: http://nodejs.org/
[2]: http://npmjs.org/
[3]: http://yeoman.io/gettingstarted.html
[4]: https://www.youtube.com/watch?v=ZhfUv0spHCY
