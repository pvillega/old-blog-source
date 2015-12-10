---
layout: post
title: "Scala Exchange 2015 Day One"
tags: [scala, scala-exchange, scalax]
image:
  feature: background.jpg
date: 2015-12-10T09:53:36+00:00
---

[Scala Exchange 2015](https://skillsmatter.com/conferences/6862-scala-exchange-2015#program) is on! I will be updating this entry with summaries on the talks I attended. Typos a plenty, be warned, but I hope this proves useful to somebody while we wait for the videos to be made available.

<!-- more -->

# Keynote: Scaling Intelligence: moving ideas forward 

By [Jessica Kerr](https://twitter.com/jessitron)

Scala as a language is about scaling. There is an inherent limit on development: what fits in our head (see this [other talk](http://www.infoq.com/presentations/complexity-simplicity-esb) by Jessica Kerr and Dan North). Given that limit, we need to scale outside of ourselves, use our team and community. People learn best in teams, people are not superstars by themselves, great teams create stars.

Most of what we do is not coding, nor learning, but teaching. We teach computer what to do, teach business about their own process (via requirement gathering), teach users via the UI we build, and we teach each other. Reusable code, flexible code, that is learnable code. A good commit message, that teaches what intention is behind the change. Documentation teaches what something does.

We want people in our community as only that way we can scale that knowledge that makes us better. There are two things we need to know about Scala which we can only learn from members and group diversity:

- Clarity: a teacher looks at the context of the learner, appreciates that context and adapts to that to teach. If something is not clear to you is not your fault, it is being explained wrong.
- Usefulness: if code is not useful then it doesn't matter how correct it is. Determined by aggregate support of the community.

Scala is designed to scale the community. Scala is supposed to be a staircase, to start by using features that make more sense to us and gradually learn more things and advance. But currently you can hit roadblocks due to lack of context when trying to learn something, which forces you to learn stuff you do't care about not or you are not ready to tackle.

You should write blogs, even for very basic information. Writing blogs helps less experienced people to find solutions to problems when they Google the error and they learn why something is that way. If many people do this we accelerate the community and help moving to next step in the language.

Documentation written by leaders or experts of a community that know too much on the subject is too sparse as they have too much context. They can't scale a community themselves. New joiners, with less experience, can help because they can identify what context is needed for an explanation. Scala can be hard, don't feel stupid for nto understanding! Write and collaborate. 

Your contribution is valuable. If something (blog post, stack overflow question) helps you, writing a post pointing to it and saying that helped you and how it was useful makes Google raise its relevance and helps the community to find it easily, helping all. Writing that makes you part of Scala. A language by itself doesn't do anything, Scala is part of a programming system that includes libraries, tools, editors, AND the community.

We can learn a lot from the Ruby community (and they can learn about language form us :P) It is a community that has scaled and it is still growing, still writing very useful software in it. We can learn on how they interact with each other, we can bring the same community scale to us.

We can learn things like:

- Scala values evolution vs stability. Ruby solved this dilema because libraries have a lot of maintainers, so they can be upgraded and evolve while being stable. In Scala with Typesafe, Typelevel you are still good. But other groups (Twitter, Foursquare, etc) which have few maintainers you are at risk, you don't know when will they use newer idioms.

- What is idiomatic scala? Still not clear, everybody's Scala is different, and we spend time arguing about this while people leaves the community. We need to find a way, and only the community can do that, no one can tell us, no other community can offer us the solution. Ruby found a way to solve this issue and developed common idioms, we can too. Ruby spent time where people was reading each other's useful code (business code, not library code), which helps spreading knowledge.


You should approach code with humility and respect for the reader. Be a teacher. For example: always include imports on your code examples and be explicit on the imports you use (not just ._). Give context.

Beware symbolic representations.They make things harder than necessary. Words are clearer than symbols and can be Googled, so really make sure that symbol is necessary. Naming in scala is a very strong asset, we should use this power more. Naming is hard, but then if it is hard, do it more! It is hard because you need to think about the problem you solve. So do it.

Avoid words like simply, obviously, etc... They tell you are supposed to know something you may not know. As a teacher, help the students by being more clear, providing links, helping to set a context for the action. Use 

Use Stack Overflow. Write blog posts. All that helps the community. We need to discuss not only the language and FP but also code style, tools, etc. Don't just show syntax, teach me why is that option better, what is the concept behind. Make documentation better and more complete.

Accept help from newer users. Saying 'no, that is not the right way' to a pull request you have closed the door of the community to that person. Accept pull-requests, even more so for documentation. If it is not great, help that person to improve but don't shut the community's door to new joiners.

Assuming context or acting like someone is stupid for not knowing context is a bad idea. That will alienate people and hurt us as a group. Don't define scala documentation in terms of learn you a Haskell. If you learn scala you want to learn Scala in Scala's context, asking me to learn Haskell is not the way. Don't ask me to learn category theory to write a useful business application. Give me the context I need to do what I want.

Finally, publish boring Scala code that teaches business domain and how to build useful things to the community. Use that hashtag  #blueSkyScala to spread that knowledge to the community.

***

# Functional Patterns for FP beginners 

By [Clément Delafargue](https://twitter.com/clementd)

(Note: you should watch the video once released to see more detailed examples on the concepts)

Functional programmer, day to day work with Javascript, but what I learned from Scala helped to write better JS. This talk is about simple patterns for FP. Not common abstractions like Functors or Monads, no Category Theory, but the tools we can use to build these abstractions. This is a way (of many possible) to do these things. Customise it to your needs.

Scala documentation in FP refers mostly to Haskell documentation, but if you don't know Haskell that is a problem. Here we want to avoid that and focus on common FP patterns. 

FP (functional programming) being 'programming with values', where everything is an expression and you tweak values to get to the desired result. For example `if` is not a block anymore, is an expression that returns a value. Pattern match is not a substitute for switch, is a way to produce a value.

We have Typed FP in Scala. All your expressions have types and you can type check the results, letting the compiler check the control flow and ensure correctness. 

## Algebraic data types (ADT)

We use Algebraic Design, where you start with values, combine values and get desired values. Your workflow is data driven. So how do we model the data? Via Algebraic data types (ADT).

Algebraic because they have two properties:

- Product types: compound type created by combining two or more types. Example: Tuple; case class User(name: String, age: Int)
- Sum types (or Co-products): a simple example is a Json value, which can be either a string, object, array or number. A Sum type is a group of values. In Scala this is implemented via a `sealed trait` and we use pattern matching to work with them (deconstruct and inspect structure). Example: 

```
sealed trait JsonElem

case classe JsonBoolean extends JsonElem

case classe JsonNumber extends JsonElem

```

Pattern matching raises compiler warnings if you forget a member of the Sum, which is handy. In Scala you can also combine Sum types to share elements across types. An example is Json is 'root elements' or Json values (which can be only object or array) vs all possible Json elements.


```
sealed trait JsonElem
sealed trait JsonValue

case classe JsonBoolean extends JsonElem

case classe JsonNumber extends JsonElem

case classe JsonObject extends JsonElem with JsonValue

case classe JsonArray extends JsonElem with JsonValue

```

OOP makes it easy to add cases, while FP makes it easy to add functions. Compiler helps in both cases, but there is a trade-off for the developer. Thankfully in Scala you can choose the way you want to implement things as it gives both options.

Should you hand roll your own ADT or use generic types (like tuples or Either)? ADT are preferred unless you are deconstructing the result right away, as when the application grows your own ADT will help you more (compiler works for you).

Sum and Product types keep properties of mathematical sum and product, like associativity, exponentials and factorisation. We have neutral value (Unit). For example:

```
A * 1  => A  and  (A, Unit) => A
A + 0  => A  and  A | Unit => A

(User("Me", 27), Pet("cat"))  and  UserWithPet("Me", 27, "cat")
// more examples in the video, watch it
```

These are equivalent but one gives more information via types:

```
sealed trait X
case class Bad(v: String) extends X
case class Good(v: String) extends X

case class Y(v: String, isGood: Boolean)
```

Please void booleans in ADT, you want to use the types to provide information. Types make you more precise and allow compiler to type check.

ADT are used to do Domain Driven Design, where you observe your data and build domain based on that. Much better than POJOs.


## Programming with Contextualised Values

We can program expressing into types if a computation failed, is asynchronous, etc.

### Error handling

`Option` type is useful when only one thing can go wrong. For example when you parse String to Integer, there is no need of extra precision. It is simple to use, but restricted, if many things can go wrong you are losing information.

`Either` is a Sum type (Left -> Error, Right -> value) which allows you to handle several errors cases. Please use ADT to describe errors as Strings provide less information on the error type. With ADT you can handle all error cases. Beware `Either` is not biased in Scala and doesn't work too well with type inference. You can use `Disjunction` from Scalaz which behaves better and it's biased (defaults to Right and provides flatMap operation to use inside a for-comprehension). 

If chained, both `Either` and `Disjunction` fail on the first error. Sometimes you want to accumulate errors, then you should use `Validation` from Scalaz. The error list is a `NonEmptyList` to ensure we have error messages on failure.

Sometimes you want to accumulate errors, some times you want to fail on first error. Don't flatten your errors, decide what is what you want. 

### Extend types

Type `Monoid` allows you to combine 2 values and provides a neutral element. With subclassing you can't declare a Zero element or extend Standard library classes (they are final). The workaround is to use `traits` that provide the desired behaviour and that you pass as additional parameter to functions.

To avoid the work of explicitly passing that new type as a parameter, you declare the new type as implicit so the compiler autowires the proper implementation. Just be careful with Typeclass convergence where a type could have multiple implementations of the same behaviours, which causes problems.

Simulacrum library helps you creating typeclasses and boilerplate for these types. 

(see examples from the talk when the video is published)

Recommended to read Cats code as it is simple code and will help you understand.

Final tips as we are running out of time:

- Use property testing for everything
- Separate effects from logic (Free Monads?)
- Read FP in Scala book

***

# Building a CQRS application using the Scala Type System and Akka 

By [Renato Cavalcanti](https://twitter.com/renatocaval)

Content of talk comes from current work done by Renato for the Belgium Government, so real world problems and lessons.

CQRS: the idea behind is to have 2 objects, one which accepts commands and produces events, another object which receives the events and generates views on the model. If you don't use event sourcing you need to produce event and save both write and read model in same transaction, otherwise you will lose event and data. If the commit fails, you have a problem. That is why event sourcing is important, as events can be stored and replayed.

## Command

Replaying events is very powerful, as you can use the stored events from production in a test environment to check all your components work as expected and produce the desired results. Facilitates verification of code.

The talk will show how to use CQRS in Akka, please watch video for full code examples. The examples uses mostly Akka-Http and Akka-Stream, two solutions for pretty well defined domains that help building the solution. The problem with Akka is that Akka is in fact a function to => Any, which means you lose type safety and has its own problems.

The solution is to build something on top of Akka that isolates you from these issue. You find the building blocks of a CQRS system, following DDD: `DomainCommand`, `DomainEvent` and `Aggregate`. These are traits that help you define your building blocks.
We also define some functions to validate events (which return a Future) and to construct Aggregates from DomainEvents.

That solved, we have another issue to tackle. We need to persist the events, which we can do via Akka Persistence. We don't store the message received in the actor, but the event generated as reaction to that message. If an Aggregate (implemented as an actor) is restarted, it can recover its status from reading the chain of events in the event-store.

But for all this to work we need a Protocol, a set of command and events for a given Aggregate. We also define the Behaviour (mapping between commands and events). We can create a DSL to facilitate generating Behaviours for an Aggregate. 

[Renato now shows code showcases the implementation of a Protocol, the corresponding Behaviour DSL and an Aggregate. Please watch video for more details]

If I have Aggregate, Protocol and Behaviour then I can create an AggregateManager, an Actor, that creates AggregateActors and manages its life-cycle. Your AggregateService is fully typed, via the protocol, and the Manager abstracts the Akka details from you.


## Query 

The Query side is about reading the events and producing Views on the data. We use Akka Persistence Query, an experimental feature. An actor generates a Projection from the events, so we don't need to recalculate the status every time (snapshot-style). Each projection has an id to identify it and provide versioning. The actor doesn't accept new events while generating a Projection, only after it has finished.

[Renato now shows code of the Query part of the system]

The Projection object is not typed, as usually you handle multiple events in a single projection. A future improvement is to strongly type projections, but not there yet. A Projection also has more data than the Aggregate stores, as there may be inferred data that is valuable for the business when viewing data, but we don't need to store explicitly.

The DSL used by Renato also provides methods to `watch` a Projection, so we can detect events and, for example, wait until all events required are received before generating a projection result.

## Takeways

Given a Protocol, Behaviour and Aggregate then you can have an actor that understand the life-cycle and a fully typed AggregateService.

Command validations can usually be asynchronous, but events must be pure and always succeed.


***

# Keynote: Without Resilience, Nothing Else Matters 

By [Jonas Bonér](https://twitter.com/jboner)

If your application is not available, doing something useful, nothing else matters: quality, speed, etc.

"It isn't about how hard you hit, is about how hard can you be hit and keep moving forward. [...] That's how winning is done." (from Rocky Movie)

Fault tolerance is not enough. Resilience is beyond fault tolerance, and it's all that matters. Resilience is the ability to spring back into shape, to recover quickly from difficulties. Software today can be incredibly complex, and we need to understand resilience in the context of these complex systems.

A complicated system has multiple small parts that interact to do something. It can be understood, although it is hard. A complex system is made of many similarly interacting parts with simple rules (ala Game of Life). Those rules define emerging properties which are impossible to understand. You can understand individual rules, but not the full interactions and outcomes. Complicated is not the same a Complex.

Complex systems run in degraded mode. Complex systems run as broken systems. In a Complex system there is something failing somewhere, always! And humans make things worse, as complex systems are counterintuitive and when we use intuition we usually end up worsening the existing issues.

Complex systems operate at the edge of failure. There is the economic failure boundary, where you can run out of business. There is the unacceptable workload boundary where you can't cope with the work. There is the accident boundary, when an undefined event causes us to fail. The operating point moves between these boundaries, and if it crosses one of them we fail.

This means we have 3 pressures on the operating point. Management tries to minimise economic failure, workload tends to least effort, and as a result we are pushing the point towards the accident boundary which is undefined. We try to counteract with tools, systems, but this keeps happening as we can't understand all implications. The only solution is to add an error margin to protect us from failure, so when we get into dangerous territory we can act before we fail.

The problem is that we don't know much, if anything, about the failure boundary so it is hard to define a proper error boundary. And we keep pushing it closer to the failure boundary as the system looks stable to us, until the point where the boundary is not helping anymore and we fail.

We must embrace failure. We know complex systems always work as broken system, so we need to accept failure as normality. We must understand that resilience is by design, it can't be bolted in afterwards. 

"In the animal kingdom simplicity leads to complexity which leads to resilience". Complexity may help building resilience. Another example on how complexity builds resilience is how the current world protects us: it feeds us, give sus shelter, etc. And it is very complex. So we can learn about resilience in both biological and social systems:

- Feature diversity and redundancy
- Interconnected network structure
- Wide distribution
- Capacity to self-adapt and self-organise

How does this apply to computer systems? We need to change the way we manage failure. Failure is natural and expected. One way: Let it crash, like Erlang does.

So we have Crash Only software (name of a paper). Stop is equal to crash safely. Start is equal to recover fast from a crash. We can apply this recursively and turn the big sledgehammer into a scalpel to tolerate failures at many levels. It is recommended to read the paper.

We need a way out of the 'State Tar Pit' (another paper). A lot of failure is related to data (partial data, wrong data, etc). We have input data, provided by customers, and derived data, data we compute from the input data. The critical one is input data, that we need to keep and take care of to avoid annoying users.

In the traditional way of managing state a error at the end of an input path will cause all the path to fail and we will lose the input data, which is an utterly broken way to manage this. We react to this by abusing defensive programming, adding try-catch blocks everywhere, etc.

"Accidents come from relationships, not broken parts." A Sane failure model means that Failures need to be:

- Contained to avoid cascading failures
- Reified as messages
- Signalled asynchronously
- Observed by at least 1 actor, up to N observers

Basically, the bulkhead pattern used by ship industry. If a compartment breaks the ship is not affected. But we can still do better, by adding Supervision: observe and manage failures from a healthy context. Components that fail should notify the Supervisor so something can be done about it. An 'Onion Later State & Failure management' or 'Error Kernel pattern'. The kernel delegates all work and supervises so the task is performed correctly, managing any errors as necessary. We apply this recursively, with a layer managing failures of the underlying level.

We can't put all eggs in same basket. We need to maintain diversity and redundancy. Servers crash, AWS goes down. We need multiple servers, even multiple data centers, which means running a distributed system. And they should be decoupled in time (to enable concurrency) and space (enables mobility of nodes). This gives a very solid base for resilience.

We need to decompose systems using consistency boundaries. We need to think about isolation of components. We need to start with the weakest consistency guarantees we can, and add stronger ones as we go if we need them. The less ACID and coordination you need, the better. Within the boundary we can have strong consistency (example: actors are single threaded with an inbox). Between boundaries it is a 'zoo', all bets are off, we need to manage failure as described above. But that is good, as weak coupling and other properties of the 'zoo' enhance our resilience.

Remember: strong consistency is the wrong default, it adds too strong coupling, but what we need is to decompose systems and create safe islands (consistency boundaries).

To conclude, let's talk about resilient protocols, the way to manage the 'zoo' outside consistency boundaries. They depends on asynchronous communication and eventual consistency. They must embrace ACID 2.0 (Associative, Commutative, Idempotent, Distributed); they must be tolerant to message loss, reordering, and duplication. 

Remember: Complex systems run as borken systems. Something is always failing. Resilience is by design. Without resilience, nothing else matters.

***

# A purely functional approach to building large applications 

By Noel Markham

Coming Soon!





