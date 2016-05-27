---
layout: post
title: "On Free Monads"
tags: [free monad, monad, cats, functional programming, scala]
image:
  feature: background.jpg
date: 2016-05-25T19:01:05+01:00
---

The concept of [Free Monad](http://typelevel.org/cats/tut/freemonad.html) is becoming popular, or at least I've seen plenty of mentions about it in the Scala Functional Programming community as of late. Why is it relevant?

<!-- more -->

A couple of warnings before I start. Judging by the code I wrote, this will be a *very long* post. You can get the [code](https://github.com/pvillega/free-monad-sample) and come back to read this post later. Also, I'm going to take a *practical* approach to Free Monad. I'll provide a list of relevant links at the end you can use to learn more about Free Monad and its nuisances, including Cat's explanation on [the theory behind Free](http://typelevel.org/cats/tut/freemonad.html#what-is-free-in-theory)

Let's do this.

## Why should I care about Free Monad?

Anything related to [Monads](http://typelevel.org/cats/tut/monad.html) seems scary and complex for the uninitiated. Why should I spend time learning that? What's the benefit?

There are descriptions of [Free Monad](http://typelevel.org/cats/tut/freemonad.html) that give a good overview on why to use it. In my humble opinion, the main benefit that Free provides is separation between the program definition and its execution. 

You start by building an embedded DSL, which can be understood by the business. Using that language, you define a program as a series of actions that cover a business case, without any implementation details associated. 

At this point you can test the business-defined logic in isolation (with fast unit tests, no need of mocks). You can *talk the same language* as the business. And only at the end, when needed, you provide a *real-world* implementation that interacts with 3rd party services and such.

This has the potential to provide more robust code, that can be tested easily, and which is a better fit to the business requirements. Also, replacing implementations (say, you change your sms provider) has minimal impact in the codebase. Wether you do [DDD](https://en.wikipedia.org/wiki/Domain-driven_design) or not, all this must sound *very appealing* ;)

In addition, implementations of Free Monad (both in Cats and Scalaz) provide other benefits, for example the use of Trampolining for stack-safe recursion.

A bit like with [Monad](http://typelevel.org/cats/tut/monad.html), a [Free Monad](http://typelevel.org/cats/tut/freemonad.html) is a relatively simple concept behind a scary name. Easier than it seems, and very useful. Either that, or I've understood nothing and need to go back to the study desk ;)

## A business case

I'll start with a very simplistic business case. We want to implement an application to buy and sell stocks. Our standard approach may generate code similar to:

``` scala
object Orders {
	type Symbol = String
	type Response = String
	def buy(stock: Symbol, amount: Int): Response = ???
	def sell(stock: Symbol, amount: Int): Response = ???
}
```

But we have heard about this new thing called `Free Monad` and we want to use it. We start by creating a DSL, a business language, that describes our actions. For example, we convert

``` scala
  def buy(stock: Symbol, amount: Int): Response
```

into 

``` scala
  case class Buy(stock: Symbol, amount: Int) extends Orders[Response]
```

You can see there is an equivalence in meaning between the two forms: case class parameters and method parameters, return value and type parameter in our case class (specifically in `Orders[Response]`). We are converting our methods into a language, but one that has no implementation associated.

If we do this with both methods, we get:

``` scala
  sealed trait Orders[A]
  case class Buy(stock: Symbol, amount: Int) extends Orders[Response]
  case class Sell(stock: Symbol, amount: Int) extends Orders[Response]
```

Please take a moment to see and understand the parallelisms between the above implementation, using case classes, and our original methods. Note that the parent trait `Orders` is similar to a `Functor` (a structure with a hole); this is a requirement of `Free`, all the languages you define *must* follow a similar structure.

So, what do we have at this point? We have a language that defines buying or selling a stock. But it has no logic associated, and creating an instance does nothing (besides instantiating the case class). Furthermore, we can't try to compile something like:

``` scala
  for {
	r <- Buy("FB", 100)
  } yield r
```

as it won't work. We need to turn this into a Monad, somehow.

## Lifting to Free

To be able to use the language in our programs, we want to convert it into something we can run. For example, a Monad. That's the task of a Free Monad, and Cats provides a very easy way to do that:

``` scala
  import cats.free.Free
  
  type OrdersF[A] = Free[Orders, A]
```
  
We have defined a new type, a `Free` Monad on `Orders` and a parameter `A`. But that's not enough, we need to map our case classes to instances of `Free`. Thankfully `Free` itself makes this step easy: 

``` scala
  import cats.free.Free._
  
  def buy(stock: Symbol, amount: Int): OrdersF[Response] = liftF[Orders, Response](Buy(stock, amount))
  def sell(stock: Symbol, amount: Int): OrdersF[Response] = liftF[Orders, Response](Sell(stock, amount))
```

See

>>> on issues with Free Monad!
https://twitter.com/alexelcu/status/736090380999888898
http://www.slideshare.net/KelleyRobinson1/why-the-free-monad-isnt-free-61836547

## Performance

Every time we add an abstraction, performance may suffer. I've not done any tests on performance using this approach, but given I found a couple of references on the subject I thought I'd mention it. 

This [Free Monad explanation](http://okmij.org/ftp/Computation/free-monad.html) says about performance:

> Do we have to pay for all the benefits of free and freer monads in performance? 
> With the simplest free and freer monads described so far: yes, the performance suffers.
> One should keep in mind that performance does not always matter: a large portion of software
> we successfully interact with every day is written in Python, Perl or Ruby, and which are not 
> exactly speed kings.

[Pascal Voitot](https://twitter.com/mandubian) wrote last year a post on [better implementations](http://mandubian.com/2015/04/09/freer/) of Free. As far as I understand, some of the concepts are already implemented in Cats and, if performance is a big concern for you, this may solve the issue or make it an acceptable trade-off.

As usual, each use case is different. You should test your implementation to ensure resulting performance is acceptable to you.

## Thanks

With concepts like Free Monad existing literature and people's help are crucial to understand the details. It would be unfair to not mention all these contributions that helped me to understand (or so I hope) Free Monad, and to write this post.

There's plenty of information online that has been extremely useful. The most relevant links are listed in the next section. A big thanks to all the authors, the time spent on that documentation has helped at least one person :) 

I need to thank [Miles Sabin](https://twitter.com/milessabin), [Channing Walton](https://twitter.com/channingwalton), and [Lance Walton](https://twitter.com/lancewalton), as  experimentation we did with Free Monad helped me understand better a lot of basic concepts related to it.

Many thanks to [Julien Truffaut](https://twitter.com/julientruffaut). He pointed to `traversableU` as the solution to mixing `List` results in the program for `Orders`. I got stuck in that case and, without his contribution, I'd be giving a horribly wrong solution to you, my reader.

Last, but not least, I need to thank [Cat's Gitter channel](https://gitter.im/typelevel/cats), in particular [Adelbert Chang](https://twitter.com/adelbertchang), as he solved a few misconceptions I had whilst porting a Free Monad built using Scalaz to a version using Cats.

## References

I've used a lot of sources to improve my understanding on Free Monad. Below you can find a list of links that I found very relevant and helpful:

* Cats definition (very good explanation): http://typelevel.org/cats/tut/freemonad.html
* Free Monad technical explanation: http://okmij.org/ftp/Computation/free-monad.html
* Tim Perrett's blog post (uses Scalaz): http://timperrett.com/2013/11/21/free-monads-part-1/
* Underscore post by Noel Welsh (uses Scalaz): http://underscore.io/blog/posts/2015/04/14/free-monads-are-simple.html
* A second post by Noel Welsh: http://underscore.io/blog/posts/2015/04/23/deriving-the-free-monad.html
* The always useful Tutorial for Cats: http://eed3si9n.com/herding-cats/Free-monads.html
* *A year living Freely* by Chris Myers: https://www.youtube.com/watch?v=rK53C-xyPWw  
* A post by John A De Goes (uses Haskell) http://degoes.net/articles/modern-fp


That's all for now, I hope this was informative and useful. As always, feedback via Twitter/Email is more than welcome. Cheers!

PS: Hold the door.