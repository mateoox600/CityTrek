extends Node2D

const data = preload('res://data/Game/priceData.gd').DATA

var pop = 0
var maxpop = 0
var money = 0
var wood = 0
var maxwood = 0
var stone = 0
var maxstone = 0
var house = 0
var miner = 0
var lumber = 0
var tile_select = 0

func _ready():
	$Camera/HUD/Values/Selection/Selection.frame = 3
	maxpop = 5
	pop = 5
	money = 15000
	wood = 4000
	maxwood = 20000
	stone = 2000
	maxstone = 10000
	

func _physics_process(delta):
	
	labelUpdate()
	
	checkClick()
	checkSelectTiles()
	checkResources()
	
	addResources()

func labelUpdate():
	
	$Camera/HUD/Values/Pop/Pop.text = "Population : " + String(int(pop)) + " / " + String(int(maxpop))
	$Camera/HUD/Values/Money/Money.text = "Piece d'or : " + String(int(money))
	$Camera/HUD/Values/Wood/Wood.text = "Bois : " + String(int(wood)) + " / " + String(int(maxwood))
	$Camera/HUD/Values/Stone/Stone.text = "Pierre : " + String(int(stone)) + " / " + String(int(maxstone))

func checkClick():
	var left_click = Input.is_action_just_pressed("left_click")
	if left_click:
		var tile_pos = $Builds.world_to_map(get_global_mouse_position())
		var cell = $Map.get_cellv(tile_pos)
		var cell1 = $Builds.get_cellv(tile_pos)
		if cell == 0 and cell1 != 0 and cell1 != 1 and cell1 != 2:
			if tile_select == 0:
				buyHouse(tile_pos)
			if tile_select == 1:
				buyMiner(tile_pos)
			if tile_select == 2:
				buyLumberJack(tile_pos)

func buyHouse(tile_pos):
		if money >= data[0].moneyprice and wood >= data[0].woodprice and stone >= data[0].stoneprice:
			money -= data[0].moneyprice
			wood -= data[0].woodprice
			stone -= data[0].stoneprice
			$Builds.set_cellv(tile_pos, 0)
			maxpop += 5
			house += 1

func buyMiner(tile_pos):
		if money >= data[1].moneyprice and wood >= data[1].woodprice and stone >= data[1].stoneprice:
			money -= data[1].moneyprice
			wood -= data[1].woodprice
			stone -= data[1].stoneprice
			$Builds.set_cellv(tile_pos, 1)
			miner += 1

func buyLumberJack(tile_pos):
		if money >= data[2].moneyprice and wood >= data[2].woodprice and stone >= data[2].stoneprice:
			money -= data[2].moneyprice
			wood -= data[2].woodprice
			stone -= data[2].stoneprice
			$Builds.set_cellv(tile_pos, 2)
			lumber += 1

func checkSelectTiles():
	var next = Input.is_action_just_pressed("next_select")
	var previous = Input.is_action_just_pressed("previous_select")
	var new_tiles = tile_select
	
	if next:
		new_tiles += 1
	elif previous:
		new_tiles -= 1
	
	if tile_select < 0:
		new_tiles = 0
	elif tile_select > 2:
		new_tiles = 2
	
	$Camera/HUD/Values/Selection/Selection.frame = new_tiles + 3
	tile_select = new_tiles

func checkResources():
	if pop > maxpop:
		pop = maxpop
	elif pop < 0:
		pop = 0
	
	if wood > maxwood:
		wood = maxwood
	elif wood < 0:
		wood = 0
	
	if stone > maxstone:
		stone = maxstone
	elif stone < 0:
		stone = 0

func addResources():
	
	pop += 0.05 * house
	money += 0.05 * ((pop - 5) / 2)
	wood += 0.05 * lumber
	stone += 0.05 * miner