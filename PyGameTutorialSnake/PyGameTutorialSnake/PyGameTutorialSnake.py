import pygame
import random
pygame.init()

#setup display
display_width, display_height = 1280, 720

fps=0
gameDisplay = pygame.display.set_mode((display_width, display_height)) 
pygame.display.set_caption("Snake") #sets the title of the game in the top of the bar
#Setup clock and FPS
clock = pygame.time.Clock()
FPS = 3
#Define Colors
white = (255,255,255)
black = (0,0,0)
bgcolor = (200,200,200)
player_color = (46,221,35)
food_color = (255,0,0)
bg = pygame.image.load("Images/bg.jpg")
#Define Player
player_size = 20
playerX = (display_width/2) - (player_size)
playerY = (display_height/2)- (player_size)
food_size = player_size
foodX=0
foodY=0
player_heading = "NA"
playerY_speed = 0
playerX_speed = 0
headindex = 0

def player(player_size, snakeList):
        
    
    snakeHeadsprite.draw(gameDisplay, headindex, snakeList[-1][0], snakeList[-1][1], 0)#draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)
    for XnYnI in snakeList[1:-1]:
        snakesprite.draw(gameDisplay, XnYnI[3], XnYnI[0], XnYnI[1], 0)#draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)
    
    if len(snakeList) > 1:

        if (snakeList[1][3] == 5 or snakeList[1][3] == 8 or snakeList[1][3] == 9) and snakeList[1][2] == "UP" :
            snakesprite.draw(gameDisplay, 2, snakeList[0][0], snakeList[0][1], 0)#draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)

        if (snakeList[1][3] == 5 or snakeList[1][3] == 0 or snakeList[1][3] == 1) and snakeList[1][2] == "DOWN" :
            snakesprite.draw(gameDisplay, 6, snakeList[0][0], snakeList[0][1], 0)#draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)

        if (snakeList[1][3] == 4 or snakeList[1][3] == 0 or snakeList[1][3] == 9) and snakeList[1][2] == "RIGHT" :
            snakesprite.draw(gameDisplay, 3, snakeList[0][0], snakeList[0][1], 0)#draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)

        if (snakeList[1][3] == 4 or snakeList[1][3] == 1 or snakeList[1][3] == 8) and snakeList[1][2] == "LEFT" :
            snakesprite.draw(gameDisplay, 7, snakeList[0][0], snakeList[0][1], 0)#draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)


#define initializing the game first run
def gameInit():
    global foodX
    global foodY
    global playerX
    global playerY
    global snakeList
    global snakeLength
    global lastindex
    global lastplayer_heading
    global headindex
    global index
    snakeLength = 3
    foodX = random.randrange(0, display_width-food_size, food_size)
    foodY = random.randrange(0, display_height-food_size, food_size)
    playerX = (display_width/2) - (player_size)
    playerY = (display_height /2)- (player_size)
    snakeList = []
    index = 1
    lastindex = 1
    lastplayer_heading = "NA"
    headindex=0
    index = 2


font = pygame.font.SysFont(None,25)
def message_to_screen(msg,color):
    #global gameDisplay
    screen_text = font.render(msg,True,color)
    gameDisplay.blit(screen_text, [display_width/2,display_height/2])

#Define game exit
def gameExit():
    pygame.quit()
    quit()


#define mooving food
def move_food():
    global foodX
    global foodY
    #foodX = random.randrange(0, display_width-food_size, food_size)
    #foodY = random.randrange(0, display_height-food_size, food_size)


class spritesheet: #used the following link to create https://www.youtube.com/watch?v=mfX3XQv9lnI&t=499s 
	def __init__(self, filename, cols, rows):
		self.sheet = pygame.image.load(filename).convert_alpha()
		
		self.cols = cols
		self.rows = rows
		self.totalCellCount = cols * rows
		
		self.rect = self.sheet.get_rect()
		w = self.cellWidth = int(self.rect.width / cols)
		h = self.cellHeight = int(self.rect.height / rows)
		hw, hh = self.cellCenter = (int(w / 2), int(h / 2))
		
		self.cells = list([(index % cols * w, int(index / cols) * h, w, h) for index in range(self.totalCellCount)])
		self.handle = list([
			(0, 0), (-hw, 0), (-w, 0),
			(0, -hh), (-hw, -hh), (-w, -hh),
			(0, -h), (-hw, -h), (-w, -h),])
		
	def draw(self, surface, cellIndex, x, y, handle = 0):
		surface.blit(self.sheet, (x + self.handle[handle][0], y + self.handle[handle][1]), self.cells[cellIndex])

snakesprite = spritesheet("Images/snake.png", 4, 3)
snakeHeadsprite  = spritesheet("Images/head.png", 4, 1)



gameInit()

while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            gameExit()
        if event.type == pygame.KEYDOWN:

            if event.key == pygame.K_ESCAPE :
                gameExit()
            if event.key == pygame.K_UP and (player_heading == "LEFT" or player_heading == "RIGHT" or player_heading == "NA"):
                playerY_speed -= player_size
                playerX_speed = 0
                player_heading = "UP"
                index = 5
                headindex = 0
            if event.key == pygame.K_DOWN and (player_heading == "LEFT" or player_heading == "RIGHT" or player_heading == "NA"):
                playerY_speed += player_size
                playerX_speed = 0
                player_heading = "DOWN"
                index = 5
                headindex = 2
            if event.key == pygame.K_LEFT and (player_heading == "UP" or player_heading == "DOWN" or player_heading == "NA"):
                playerX_speed -= player_size
                playerY_speed = 0
                player_heading = "LEFT"
                index = 4
                headindex = 3
            if event.key == pygame.K_RIGHT and (player_heading == "UP" or player_heading == "DOWN" or player_heading == "NA"):
                playerX_speed += player_size
                playerY_speed = 0
                player_heading = "RIGHT"
                index = 4
                headindex = 1
            if event.key == pygame.K_SPACE:
                move_food()

    
  


    playerX = playerX + playerX_speed
    playerY = playerY + playerY_speed      
    
    #check for border collision
    if playerX < 0 or playerY < 0 or playerX > display_width - player_size or playerY > display_height - player_size:
        gameInit()
        player_heading = "NA"
        playerY_speed = 0
        playerX_speed = 0


    #check for player and food collision
    if playerX == foodX and playerY == foodY:
        foodX = random.randrange(0, display_width-food_size, food_size)
        foodY = random.randrange(0, display_height-food_size, food_size)
        snakeLength += 1
    
    gameDisplay.fill((bgcolor))
    gameDisplay.blit(bg, (0, 0))


    if player_heading == "UP" and lastplayer_heading == "RIGHT":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(0)
        snakeList.append(tempsnakeList)

    if player_heading == "UP" and lastplayer_heading == "LEFT":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(1)
        snakeList.append(tempsnakeList)

    if player_heading == "DOWN" and lastplayer_heading == "RIGHT":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(9)
        snakeList.append(tempsnakeList)

    if player_heading == "DOWN" and lastplayer_heading == "LEFT":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(8)
        snakeList.append(tempsnakeList)

    if player_heading == "RIGHT" and lastplayer_heading == "UP":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(8)
        snakeList.append(tempsnakeList)

    if player_heading == "RIGHT" and lastplayer_heading == "DOWN":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(1)
        snakeList.append(tempsnakeList)

    if player_heading == "LEFT" and lastplayer_heading == "UP":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(9)
        snakeList.append(tempsnakeList)

    if player_heading == "LEFT" and lastplayer_heading == "DOWN":
        tempsnakeList=[]
        tempsnakeList = snakeList[-1]
        snakeList.pop(-1)
        tempsnakeList.pop(-1)
        tempsnakeList.append(0)
        snakeList.append(tempsnakeList)

    if playerX_speed != 0 or playerY_speed != 0 or len(snakeList) ==0 :
        snakeHead = []
        snakeHead.append(playerX)
        snakeHead.append(playerY)
        snakeHead.append(player_heading)
        snakeHead.append(index)
        snakeList.append(snakeHead)
    #player(player_size, snakeList)




    if len(snakeList) > snakeLength:
        del snakeList[0]

    player(player_size, snakeList)
    

    for eachSegment in snakeList [:-1]:
        if eachSegment[0] == snakeHead[0] and eachSegment [1] == snakeHead[1]:
            gameInit()
            player_heading = "NA"
            playerY_speed = 0
            playerX_speed = 0

    lastindex = index
    lastplayer_heading = player_heading

    #pygame.draw.rect(gameDisplay, food_color, (foodX ,foodY,food_size,food_size))
    snakesprite.draw(gameDisplay, 10, foodX, foodY, 0)#draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)

    #print (playerX, playerY, foodX, foodY)
    
    #snakesprite.draw(gameDisplay, index % s.totalCellCount, 200, 200, 0) #draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)
    #index += 1
    #if index > 3 :
    #    index=0
        
    
    pygame.display.update()
    fps = clock.get_fps()
    message_to_screen("hello",black)
    clock.tick(FPS)