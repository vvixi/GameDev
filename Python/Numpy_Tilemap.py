import pygame, os
from pygame.locals import *
import numpy as np
import json

tileSize = 16

file = 'assets/tilemap.png'

clock = pygame.time.Clock()
pygame.font.init()
myfont = pygame.font.SysFont('Deja Vu Serif', 20)

print(__file__)
path = os.path.abspath(__file__)
dir = os.path.dirname(path)

base = os.path.basename(path)
print(base)

root, ext = os.path.splitext(path)
print(root)

def read_json(file_path):
    with open(file_path, 'r') as f:
        return json.load(f)

class Tileset:
    '''
    creates tiles from a tileset image
    '''
    def __init__(self, file, size=(tileSize, tileSize), margin=0, spacing=0, color_key = None):
        self.file = file
        self.size = size
        self.margin = margin
        self.spacing = spacing
        self.image = pygame.image.load(file).convert()
        self.rect = self.image.get_rect()
        self.tiles = []
        self.load()
        if color_key:
            self.image = self.image.convert_alpha()
            self.image.set_colorkey(color_key)

        else:
            self.image = self.image.convert_alpha()


    def load(self):
        '''
        loads the tiles from the map into the game world
        '''
        self.tiles = []
        x0 = y0 = self.margin
        w, h = self.rect.size
        dx = self.size[0] + self.spacing
        dy = self.size[1] + self.spacing
        
        for x in range(x0, w, dx):
            for y in range(y0, h, dy):
                tile = pygame.Surface(self.size, pygame.SRCALPHA)
                tile.blit(self.image, (0, 0), (x, y, *self.size))
                self.tiles.append(tile)

    def __str__(self):
        return f'{self.__class__.__name__} file:{self.file} tile:{self.size}'

class Tilemap:
    def __init__(self, tileset, size=(20, 30), rect=None, alpha=False):
        #assert read_json('config.json')
        data = read_json('assets/config.json')
        self.wallTile = data['WALLS']['whitebrick']
        self.floorTile = data['FLOORS']['cave']
        self.size = size
        self.tileset = tileset

        self.map = np.full(size, -1, dtype='int8')
 
        h, w = self.size
        if alpha == False:
            self.image = pygame.Surface((tileSize*w, tileSize*h))
        else:
            self.image = pygame.Surface((tileSize*w, tileSize*h), pygame.SRCALPHA)
            self.image.set_colorkey((0,0,0))

        if rect:
            self.rect = pygame.Rect(rect)
        else:
            self.rect = self.image.get_rect()

    def render(self):
        '''
        displays tiles
        '''
        m, n = self.map.shape
        for i in range(m):
            for j in range(n):
                if not self.map[i][j] == -1:
                
                    tile = self.tileset.tiles[self.map[i, j]]
                    self.image.blit(tile, (j*tileSize, i*tileSize))
        
    def set_zero(self):
        '''
        sets all spaces to be of one type in the map array
        '''
        self.map = np.ones(self.size, dtype='int8')
        self.render()

    def set_random(self):
        '''
        draws random tiles for every space in the map array
        '''
        n = len(self.tileset.tiles)
        self.map = np.random.randint(n, size=self.size)
        self.render()

    def make_room(self):
        '''
        creates a room with walls and floors from the first map object
        '''
        # set all wall tiles
        self.map[0, :] = self.map[:, 0] = self.map[self.size[0]-1, :] = self.map[:, self.size[1]-1] = self.wallTile
        # set all floor tiles
        self.map[1:-1, 1:-1] = self.floorTile

        # right door
        self.map[10, self.size[1]-1] = -1
        # bottom door
        self.map[self.size[0]-1, self.size[1]//2] = -1

        self.render()

    def __str__(self):
        return f'{self.__class__.__name__} {self.size}'      

class GameObject:
    def __init__(self, image, height, speed):
        self.speed = speed
        self.image = image
        self.pos = image.get_rect().move(height, height)
    def move(self, up=False, down=False, left=False, right=False):
        if right:
            self.pos.right += 1
        if left:
            self.pos.right -= 1
        if down:
            self.pos.top += 1
        if up:
            self.pos.top -= 1
    
class Game:
    '''
    coordinates the games assets
    '''
    W = 800
    H = 600
    SIZE = W, H

    def __init__(self):
        pygame.init()
        
        self.screen = pygame.display.set_mode(Game.SIZE)

        pygame.display.set_caption('Pygame Tile Demo')
        self.running = True

        self.tileset = Tileset(file)
        self.layer2 = Tileset(file)
        self.base_tilemap = Tilemap(self.tileset) 

        self.player = pygame.image.load('player.png').convert()
        self.p = GameObject(self.player, 10*tileSize, 10*tileSize)

    def run(self):
        '''
        main event loop
        '''
        while self.running:

            textsurface = myfont.render(f'wall:{self.base_tilemap.wallTile} floor:{self.base_tilemap.floorTile}', False, (255, 255, 255))
            for event in pygame.event.get():
                if event.type == QUIT:
                    self.running = False

                elif event.type == KEYDOWN:

                    if event.key == K_m:
                        self.base_tilemap.make_room()
                    elif event.key == K_q:
                        self.running = False
                    elif event.key == K_r:
                        self.base_tilemap.set_random()
                    elif event.key == K_z:
                        self.base_tilemap.set_zero()
                    elif event.key == K_x:
                        self.save_image()

            keys = pygame.key.get_pressed()
            if keys[pygame.K_w]:
                self.p.move(up=True)
            elif keys[pygame.K_s]:
                self.p.move(down=True)
            if keys[pygame.K_a]:
                self.p.move(left=True)
            if keys[pygame.K_d]:
                self.p.move(right=True)

            # base tilemap
            self.screen.blit(self.base_tilemap.image, self.base_tilemap.rect)
            pygame.transform.scale(self.base_tilemap.image, (self.SIZE), self.screen)

            # player
            self.screen.blit(self.p.image, self.p.pos)
            # text
            self.screen.blit(textsurface, (10, 10))
            pygame.display.update()
            clock.tick(32)
            
        pygame.quit()
      
if __name__ == "__main__":
  game = Game()
  game.run()
