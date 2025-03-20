extends Resource
class_name Inventory

@export var items: Array[InventoryItem]
@export var max_size: int = 18

var currently_selected_item: InventoryItem = null

func add_item(item: InventoryItem):
    items[find_next_available_index(0)] = item


func remove_item(item: InventoryItem):
    var index_to_remove = items.find(item)
    var _removed_item = items.pop_at(index_to_remove)
    items.insert(index_to_remove, null)
    return index_to_remove


func find_next_available_index(index: int):
    var item_index: int = index
    var empty_slot = null
    var end_reached: bool = false
    while empty_slot == null:
        for i in range(item_index, items.size()):
            if items[i] == null:
                empty_slot = i
                break
    
            i = i+1
            if i >= items.size() - 1: end_reached = true
            if end_reached: item_index = 0
    return empty_slot


func get_merged_items(origin_item: InventoryItem, overflow_item: InventoryItem):
    var new_quantity = origin_item.quantity + overflow_item.quantity
    var max_item = origin_item
    var min_item = overflow_item
    if new_quantity > origin_item.item.max_stack:
        var overflow_amount = new_quantity - currently_selected_item.item.max_stack
        max_item.quantity = origin_item.item.max_stack
        min_item.quantity = overflow_amount
    else:
        max_item.quantity = new_quantity
        min_item = null
    return [max_item, min_item]


func drop_item(index: int):
    var removed_index = remove_item(currently_selected_item)
    if items[index] is InventoryItem:
        if items[index].item == currently_selected_item.item:
            if currently_selected_item.item.stackable:
                var merged_items = get_merged_items(items[index], currently_selected_item)
                items[index] = merged_items[0]
                items[find_next_available_index(index)] = merged_items[1]
            else:
                items[removed_index] = currently_selected_item
    else:
        items[removed_index] = items[index]
        items[index] = currently_selected_item
    currently_selected_item = null


func drag_item(item: InventoryItem):
    currently_selected_item = item