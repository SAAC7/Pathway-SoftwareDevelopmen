import math
items=int(input("Enter the number of items: "))
items_box=int(input("Enter the number of items per box: "))
boxes = math.ceil(items/items_box)
print(f"For {items} items, packing {items_box} items in each box, you will need {boxes} boxes.")
