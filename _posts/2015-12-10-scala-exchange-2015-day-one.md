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

## Keynote: Scaling Intelligence: moving ideas forward 

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

## Extend types

Type `Monoid` allows you to combine 2 values and provides a neutral element. With subclassing you can't declare a Zero element or extend Standard library classes (they are final). The workaround is to use `traits` that provide the desired behaviour and that you pass as additional parameter to functions.

To avoid the work of explicitly passing that new type as a parameter, you declare the new type as implicit so the compiler autowires the proper implementation. Just be careful with Typeclass convergence where a type could have multiple implementations of the same behaviours, which causes problems.

Simulacrum library helps you creating typeclasses and boilerplate for these types. 

(see examples from the talk when the video is published)

Recommended to read Cats code as it is simple code and will help you understand.

Final tips as we are running out of time:

- Use property testing for everything
- Separate effects from logic (Free Monads?)
- Read FP in Scala book













