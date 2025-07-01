extends Node

var score = 0
#@onready var coin_update: Label = $CoinUpdate
@onready var score_update: Label = $"../UserInterface/ScoreUpdate"

func add_points(points: int):
	score += points
	score_update.text = str(score)

func add_point():
	score += 1
	#coin_update.text = "You have collected " + str(score) + " coins!"
	score_update.text = str(score)
