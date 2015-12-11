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

The aim of today is to see the differences between Akka and Scalaz streams. Most of the talk will be live coding, so please watch the video.

The problem we want to solve is to process data as it comes. We can't hold all the data into memory for some reason, irrelevant why. We focus on scenarios with a single node which cover a lot of common scenarios, for multi-node computations please check Spark.

Akka Streams introduces itself as a library to process and transfer a sequence of elements in a bounded buffer space. 
Scalaz Streams is a streaming I/O library focussed on compositionally, expressiveness and resource safety.

In both cases we want to define a pipeline, in a type-safe way, and then run data through it. Scalaz-stream is slightly more typesafe than Akka Streams. In both libraries the first step is to create a 'blue-print' (graph for Akka, process for Scalaz) that defines how to transform the data. After that is defined we can execute it (materialise in Akka, run in Scalaz).

The basic building blocks for Akka is a Graph (simple caseL linear pipeline), that has a source (produces elements), Sink (consumes an input) and some Flow pieces that transforms elements. At runtime each component is materialised into an Actor, and each actor does the operation defined in the relevant component. Each component also materialise into an additional value (example: Source into a Future you can use to get the result of the processing).

In Scalaz the approach is different. We initially create a data type `Process[F[_], T]`. `T` is the output type, `F[_]` describes side-effects that can occur while processing. In simplest case we have `Process[Nothing, T]` that emits `T` without any change. We also have aliases like `Sink[F[_],0] = Process[F, O => F[Unit]]`. The Process is in fact akin to a state machine.

Akka implements the reactive-streams standard, which provides back-pressure via a back-channel, via dynamic push-pull. Source only produces data when the back-channel indicates it is needed, to avoid overwhelming components downstream. Everything is actor based, things happen concurrently.

Scalaz has back-pressure for free as it is entirely pull-based. Elements are evaluated on by one, in a functional approach by which we only process one element once the state machine says we can do so. Not dependent on Scalaz except for `Task`. To be clear, Scalaz is slower than Akka version (2-3x).

(Code examples via live-coding start, please watch video. I'll try to summarise any key ideas mentioned)

In Akka operations over the Source (like `map` or `filter`) are converted into actors behind the scenes. The first example to manipulate a text file (read, filter, map and save) already creates at least 8 actors. You can't influence the concurrency.

Code in Scalaz version looks similar, just using different types as Source. Scalaz calls `run` twice, first once compiles process into a `Task`, the second runs the `Task`. If you want parallelism you need to be explicit about it, there is none by default.

In the first test Akka took 3.84s while Scalaz took 6.93s. Take in account Scalaz was using a single thread (no parallelism defined).

The second example wants to transform Int to Int, processing odd and even elements in parallel. For Akka this means creating a FlowGrap that defines the data flow by first creating components of the Graph and then declaring the connections. Beware the graph correctness is checked at runtime, not at compile time! Adam comments that creating a component, `SplitStage`, was complex and more so due to the use of a mutable API.

Scalaz version of the Int processing, all purely functional. Adam confesses it was hard to write the first time. Scalaz requires us to be explicit on parallelism, so we need to create bounded queues (for memory protection) and we use streams to add/get elements to/from them. We also need to close the queues once we are done. In the code we define several components, please watch the video to see the full structure (hard to describe without showing the code). All the code is purely functional with full control on side-effects. All the connections are checked at compile time.

In the second test Akka took 3.43s and Scalaz 3.25s, as both were waiting for 1s during processing.

***

# Fast automatic type class derivation with shapeless 

By [Alexandre Archambault](https://twitter.com/alxarchambault)

Modelisation: in Scala you use a lot of case classes and sealed traits to represent your domain. Hundreds or more on big projects. The usual tasks include conversion to/from JSON, persist in binary format, render as CSV, pretty-print, etc. You do this a lot, so you want to automate these tasks.

You could use macros, but the Scala type system is quite complex and that means you need to consider a lot of things. Also, macros have some surprises within the API (side effects). All in all, using macros to automate these tasks becomes unwieldy.

A solution is to use Shapeless instead.

A first example is a `Printer` class that takes a value of type `T` and prints it. To explain how to do it, first let's talk about `HLists`. `HLists` are a sequence of types/values, similar to Scala `List` except its elements may have different types inside the same list (`String :: Int :: HNil` as an example). We can identify a `HList` to a case class of the same types. 

As we can build `HLists` inductively, by prepending elements (`::`), we can define our `Printer` class by recursively iterating over the `HList` and printing the values. We use support `Printer` for basic types (`Printer[String]`, `Printer[Int]`, etc) and as we can decompose the `HList` into these basic components, we know we will print as expected.

As we mentioned, we can map case classes to `HList`. Given that, defining `Printer` in terms of `HList` (which is easy) provides us a way to print any existing case class in our code, including any case class we create in the future. 

Sometimes there are issues due to wrong divergences or recursive types. We can make our derivation more robust by using Shapeless' `Lazy` type, which helps the compiler resolve the issues mentioned before and handles real recursion in types properly.

A caveat to consider is that implicit priorities may cause issues in automatic generation. There are workarounds, like using `export-hook` from Miles Sabin, or break implicits into an object hierarchy.

There are ways to speed up the process, for example using [upickle](https://github.com/lihaoyi/upickle-pprint), a project that uses macros to help with type generation.

***

# Keynote: Typelevel - the benefits of collaboration 

By [Miles Sabin](https://twitter.com/milessabin)

Coming soon!

***

# Workshop: Shapeless for Mortals 

By [Sam Halliday](https://twitter.com/fommil)

It is a workshop so there will be no notes on it, sorry!

Don't forget to join us at [ScalaXHack](https://skillsmatter.com/conferences/7402-scalaxhack) tomorrow. Hope you enjoyed the content :)


