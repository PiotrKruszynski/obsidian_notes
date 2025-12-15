wywoływanie samej siebie



Składa się z przypadku podstawowego i przypadku rekurencyjnego.

def square_area_recursive(a: int) -> int:

    if a == 0:

        return 0

    return a + square_area_recursive(a - 1)


usuwanie folderów

[[functional programming]]

