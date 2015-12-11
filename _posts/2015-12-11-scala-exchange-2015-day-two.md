---
layout: post
title: "Scala Exchange 2015 Day Two"
tags: [scala, scala-exchange, scalax]
image:
  feature: background.jpg
date: 2015-12-11T09:18:39+00:00
---

[Scala Exchange 2015](https://skillsmatter.com/conferences/6862-scala-exchange-2015#program) is on! I will be updating this entry with summaries on the talks I attended. Typos a plenty, be warned, but I hope this proves useful to somebody while we wait for the videos to be made available. You can also read my [summary of day one](/scala-exchange-2015-day-one/).

<!-- more -->

# Keynote: Spark+Hadoop and how it relates to Scala 

By [Sean Owen](https://twitter.com/sean_r_owen)

Intends to give a different perspective on Scala, a less technical talk, more about his path into Scala coming from Hadoop and Java. 

Sean started with EJB and Struts. Some of these ideas faded after the dot-com bust. Moved to Google, built Barcode scanner in Android. He chose to move towards Java to avoid C++. After Google got involved with open-source in a project that ended up being Apache Mahout. There were ML systems before Hadoop, but Hadoop attracted all those Java developers interested in the area. He worked with it until 2 years ago where he moved to Spark, and Scala. 

The common thread on most of this path is the JVM. For enterprise people, everything looks like Spring/Maven/etc, the standard stack. Your world view is defined by it, you mold problems to fit that.

Why Hadoop in Java, instead of C++ which was used in Google for Map-Reduce? Officially due to the usual reasons: type-safe, garbage colector, easier to debug, libraries available, and platform independence. But Sean thinks there are other reasons: lots of people fled the dot-com burst to the safety of tech giants. Enterprise architecture meets web scale and Hadoop is born. A colleague thinks the real reason is Lucene used Java as an experiment, and Hadoop inherited that decision along the way.

Hadoop has some functional ideas from the start. Map-reduce, HDFS (immutable file system), no side effects in mappers/reducers. They probably were not taken directly from FP, they are just good ideas and assumptions that work well in a distributed environment, almost essential.

However, Hadoop 'feels' enterprise-y. For example, a Mapper is a heavy-weight object instead of a simple function. It allows you to store state, exposes threading to you, makes you manage serialisation, etc. There may be reasons behind (performance, etc) but it's not very functional.

In a parallel world, Python grew in the 'big-data' environment. Python is different: has an interpreter, sometype inference, has lambdas, libraries for ML, and pip to manage dependencies. Not at all like enterprise software. There are some nice things in the Python environment we wish we could have in the Java world (at that time). But if you are used to Java's world you won't realise you may want these things.

Then we arrive to 2014, where functional invades the Hadoop ecosystem via Spark, Kafka, and Java 8 lambdas. Mentions to Storm and other similars projects that reinforce the trend. So suddenly the JVM has access to some of the features it was lacking.

But this is not about Spark replacing Map-reduce unexpectedly, we already had projects (like Crunch) that had improved in that area so the progression is 'natural', it has been coming for a while. This is just a next step in the evolution.

Why do Scala/Spark fit Hadoop? Many reasons:

- Immutable data at the foundation, perfect match between FP and Hadoop
- Functional paradigm from the start
- Unlocks caching due to immutability, at all levels from Spark to HDFS
- Scala naturally from Java, which in turn replaced C++. Natural progression
- Hybrid imperative/functional wins, easier to adapt to and quickly grab benefits 
- Memory caching allows for fast iteration, which benefits data scientists as iteration is at the core of ML
- The provided Shell allows for exploratory analytics, makes it easier to prototype
- It's more familiar to Python devs and the environment/features they are used to

What do I like about Scala as a former Java developer?

- Love collections, say what you will but they give you a lot of expressiveness 
- Love case classes and tuples, save you a lot of boilerplate
- Love language constructs like val, lazy and match. They simplify and clarify what you intend to write
- Love closures, which are much better than Java 8 lambdas, cleaner and slicker

What do I dislike about Scala as a former Java developer?

- Dislike Option, not sure it's way better than *null*
- Dislikes incompatible minor releases, has been very painful in Spark. A big deal for projects
- Dislikes Sbt imperative style, still prefers Maven declarative style. Writing code in your build script is a step backwards when you try to understand somebody else Sbt build script.
- Dislike the fact *scalac* is incredibly heavy. Yes, he understands the Scala compiler does so much more for you, but compiling park takes so long it seems crazy on 2015.

The last complain about Scala community it's the excessive fascination with syntax, sometimes using complex functional chain of operations to express simple ideas which could be expressed in a simpler way in Java.

Scala is, no doubt, the future for Hadoop ecosystem. That is good.


***

# Streams: reactive? functional? Or: akka- & scalaz- streams side-by-side 

By [Adam Warski](https://twitter.com/adamwarski)

Coming soon!

***

# Fast automatic type class derivation with shapeless 

By [Alexandre Archambault](https://twitter.com/alxarchambault)

Coming soon!

***

# Keynote: Typelevel - the benefits of collaboration 

By [Miles Sabin](https://twitter.com/milessabin)

Coming soon!

***

# Workshop: Shapeless for Mortals 

By [Sam Halliday](https://twitter.com/fommil)

It is a workshop so there will be no notes on it, sorry!

Don't forget to join us at [ScalaXHack](https://skillsmatter.com/conferences/7402-scalaxhack) tomorrow. Hope you enjoyed the content :)


