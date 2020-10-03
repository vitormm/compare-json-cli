# Json Object Similarity Score

This repo is intended to solve the challeng described below using Ruby language

> Write a program using JavaScript (Node) that will compare two json objects and give a score between 0 and 1 as to how similar they are, a score of 1 meaning the objects are identical. There are sample JSON files in the data directory for testing.


The code was writen in ruby language and used rspec as testing framework.
It uses the Jaro-Winkler distance algorithm to evaluate the json object score. Jaro-winkler is a well known algoritm for measuring string edit distance between two sequences.
Some refs: 
* https://medium.com/@appaloosastore/string-similarity-algorithms-compared-3f7b4d12f0ff
* https://en.wikipedia.org/wiki/Jaro%E2%80%93Winkler_distance



### Usage

Ensure Ruby 2.7 (you can use rvm to manage ruby versions) is installed and also bundler is installed. 
Run the following command to install the dependencies:

```sh
bundle install
```

Run the following command to run the application
```sh
ruby compare_json_app.rb ./data/BreweriesMaster.json ./data/BreweriesSample4.json
```

If you need help, use the following command:

```sh
ruby compare_json_app.rb -h
```

You can change the json files to obtain the score between the other files


### Tests

You can run the tests with the following command:

```sh
rspec
```
