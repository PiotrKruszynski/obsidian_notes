---
title: "recursion"
type: concept
topic: algorithms
tags: ["algorithms"]
created: 2026-06-09
status: draft
sr_due: 2026-07-20
sr_last: 
sr_grade: 
sr_interval: 0
sr_ease: 2.5
sr_reps: 0
sr_lapses: 0
---

wywoływanie samej siebie



Składa się z przypadku podstawowego i przypadku rekurencyjnego.

def square_area_recursive(a: int) -> int:

    if a == 0:

        return 0

    return a + square_area_recursive(a - 1)


usuwanie folderów

[[functional programming]]
