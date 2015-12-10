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

