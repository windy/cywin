Cywin
========

[中文版说明](/README.zh-cn.md)

The source code of Cywin: <http://cywin.yafeilee.me>

A testing environment for you( do anything here if you want ): <http://cywin.yafeilee.me>, username: admin@cywin.cn, password: admin

Cywin is a stock crowdfunding platform, just like [angellist](https://angel.co) but in China.

Cywin can build the connection between startups and talented investors with stock investment.

Cywin is a full-flow platform for the investment process.

in China, its competitors are [AngelCruch, as: 天使汇](http://angelcrunch.com), [VC club, as: 创投圈](http://vc.cn) and etc.

Core process like this:

1. Startup

    Create Project -> Publish it -> Start financing -> Invite Investor leader -> Investor leader confirm -> Normal Investors follow -> Success

2. Normal investor

    * Apply Investor leader
    * Follow an investment by investor leader

3. Investor leader

    * Lead an investment of project
    * Make rule for the investment of project

Cywin now is open source.

## Why makes Cywin open-source?

After spending six month to make this project, I realized, I can not ship this platform with my parnter. With lack of resources below the line, I think, it's a fault for me to build it. It costed all my energy.

Besides, the confict of fundamental production principle with parnter was more and more serious. With never positive feedback for Cywin, I finally decided to quit the project.

A few month later, I made Cywin open source when the source code of Cywin would not be used. I hope it will be useful for other friends like you.

## Will it be maintained?

Exactly not. Since I have realized this road is wrong.

But Cywin is a pretty project. It is made by clean and neat code, its architecture is awful flexible, with lots of test cases( 120+ ).

Besides, it has beautiful UI, supports responsive page, good scss and clean AngularJS code.

In the whole, it's one of my most proud works alone.

## Can I get your help for it?

Yes, I am pleasure if you want to study AngularJS and Ruby on Rails on the strength of Cywin. If you want to continue developing, I'm glad too.

Fell free to submit your issue when you find something wrong. I will help you in my leisure time ASAP.

## Good parts you maybe get inspiration

* Message design ( template support, email push )
* Login system( customize Devise with ajax registration, invite code support )
* Role Management( rolify & cancancan )
* Hybrid AngularJS & Rails best practice development mode
* AngularJS Directives
* Responsive Design
* SCSS organization
* RESTful Design
* Multi enviornments & deployment automation ( staging / demo / production with mina )
* Sunspot search( especially Chinese tokenized system )
* TDD business logic
* best practice configuration for Ruby on Rails ( figaro )

## Core tech stack

* Ruby on Rails( 4.1 )
* AngularJS( Hybrid mode )
* Foundation 5

## Setup

0. `gem install bundler`
1. `bundle install`
2. copy config/xx.example.yml to config/xx.yml, xx contains application, database, then adjust it as you need.
3. `rake sunspot:solr:start`
4. `rake db:setup`
5. `rails s`

Visit http://localhost:3000/users/sign_in, and input ADMIN_EMAIL and ADMIN_PASSWORD( configurated in application.yml ) to login it.

## Histories of Cywin

### 2014.10.20

Quit the project

### 2014.9.15

New UI

improvement of features

### 2014.8.16

refactor category feature

improvement of features

### 2014.8.6

refactor home page

improvement of features

### 2014.4.15

Resigned responsive page, mobile first

Fundamental featctures complete

### 2014.3.26

Database design and tech choosen

-----------------

## License

It's be licensed under both [MIT](http://www.opensource.org/licenses/mit-license.php) and [GPL](http://www.gnu.org/licenses/gpl.html).

Additionally, The logos and other pictures are not allowed by commercial purpose.

If you have any question, just leave an issue for it.
