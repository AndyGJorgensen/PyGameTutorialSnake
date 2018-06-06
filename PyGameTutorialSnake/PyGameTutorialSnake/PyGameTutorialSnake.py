import pygame
import random
pygame.init()

#setup display
display_width, display_height = 800, 600

fps=0
gameDisplay = pygame.display.set_mode((display_width, display_height)) 
pygame.display.set_caption("Snake") #sets the title of the game in the top of the bar
#Setup clock and FPS
clock = pygame.time.Clock()
FPS = 1
#Define Colors
white = (255,255,255)
black = (0,0,0)
bgcolor = (200,200,200)
player_color = (46,221,35)
food_color = (255,0,0)
#Define Player
player_size = 20
playerX = (display_width/2) - (player_size)
playerY = (display_height/2)- (player_size)
food_size = player_size
foodX=0
foodY=0
player_MovingXY = "NA"
playerY_speed = 0
playerX_speed = 0

def player(player_size, snakeList):
    for XnY in snakeList:
        pygame.draw.rect(gameDisplay, player_color, (XnY[0] ,XnY[1],player_size,player_size))



    #pygame.draw.rect(gameDisplay, player_color, (playerX ,playerY,player_size,player_size))



#define initializing the game first run
def gameInit():
    global foodX
    global foodY
    global playerX
    global playerY
    global snakeList
    global snakeLength
    snakeLength = 3
    foodX = random.randrange(0, display_width-food_size, food_size)
    foodY = random.randrange(0, display_height-food_size, food_size)
    playerX = (display_width/2) - (player_size)
    playerY = (display_height/2)- (player_size)
    snakeList = []

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

s = spritesheet("Images/head.png", 4, 1)
CENTER_HANDLE = 0

index = 3


gameInit()

while True:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            gameExit()
        if event.type == pygame.KEYDOWN:

            if event.key == pygame.K_ESCAPE :
                gameExit()
            if event.key == pygame.K_UP and not player_MovingXY == "Y":
                playerY_speed -= player_size
                playerX_speed = 0
                player_MovingXY = "Y"
            if event.key == pygame.K_DOWN and not player_MovingXY == "Y":
                playerY_speed += player_size
                playerX_speed = 0
                player_MovingXY = "Y"
            if event.key == pygame.K_LEFT and not player_MovingXY == "X":
                playerX_speed -= player_size
                playerY_speed = 0
                player_MovingXY = "X"
            if event.key == pygame.K_RIGHT and not player_MovingXY == "X":
                playerX_speed += player_size
                playerY_speed = 0
                player_MovingXY = "X"
            if event.key == pygame.K_SPACE:
                move_food()
    playerX = playerX + playerX_speed
    playerY = playerY + playerY_speed      
    
    if playerX < 0 or playerY < 0 or playerX > display_width - player_size or playerY > display_height - player_size:
        gameInit()
        player_MovingXY = "NA"
        playerY_speed = 0
        playerX_speed = 0

    if playerX == foodX and playerY == foodY:
        foodX = random.randrange(0, display_width-food_size, food_size)
        foodY = random.randrange(0, display_height-food_size, food_size)
        snakeLength += 1
    
    gameDisplay.fill((bgcolor))


    
    snakeHead = []
    snakeHead.append(playerX)
    snakeHead.append(playerY)
    snakeList.append(snakeHead)
    player(player_size, snakeList)
    if len(snakeList) > snakeLength:
        del snakeList[0]

    for eachSegment in snakeList [:-1]:
        if eachSegment == snakeHead:
            gameInit()
            player_MovingXY = "NA"
            playerY_speed = 0
            playerX_speed = 0

    pygame.draw.rect(gameDisplay, food_color, (foodX ,foodY,food_size,food_size))
    #print (playerX, playerY, foodX, foodY)
    
    s.draw(gameDisplay, index % s.totalCellCount, 200, 200, 0) #draw (Display to blit to,Index number of image, locatation of X,Y,Offset 0=topleft)
    index += 1
    #s.draw.circle(gameDisplay, white, (HW, HH), 2, 0)
        
    
    pygame.display.update()
    fps = clock.get_fps()
    message_to_screen("hello",black)
    clock.tick(FPS)