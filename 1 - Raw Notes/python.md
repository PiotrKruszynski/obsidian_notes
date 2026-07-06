źródło: sesja LLM, functional, 2026-07-06

unctional Paradigm in Python
What is Functional Programming?

Functional programming (FP) is a programming paradigm where computation is expressed as the evaluation of pure functions.

A pure function:

always returns the same output for the same input
has no side effects
does not modify external state
def square(x: int) -> int:
    return x * x
square(5) -> 25
square(5) -> 25

Always.

Core Principles
1. Pure Functions

Avoid reading or modifying global state.

❌ Bad

counter = 0

def increment():
    global counter
    counter += 1

✅ Good

def increment(counter: int) -> int:
    return counter + 1

Everything needed is passed as arguments.

2. Immutability

Data is not modified.

Instead of:

numbers.append(5)

Create new data.

numbers = numbers + [5]

or

new_numbers = (*numbers, 5)