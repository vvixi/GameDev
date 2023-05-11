# simple particle system by vvixi 
# pygame 2.1.2 (SDL 2.0.16, Python 3.10.10
import pygame as pg
import sys
import random
clock = pg.time.Clock()

pg.init()
pg.display.set_caption("Particle System")

width = 640
height = 480
screen = pg.display.set_mode((width, height))

class ParticleSys ():

	def __init__(self, _posX: int, _posY: int, _speed: float, _gravity: float, _initSize):

		self.col = 255
		self.particles = []
		self.posX = _posX
		self.posY = _posY
		self.speed = _speed
		self.gravity = _gravity
		self.initSize = _initSize
			
	def addParticles(self):

		self.particles.append([[self.posX, self.posY], [random.randint(-5,5),random.randint(-5, 5)], self.initSize])

	def update(self):

		''' updates particles position and draws them  '''
		# posX, posY = pg.mouse.get_pos()		
		for particle in self.particles:
			particle[0][0] += particle[1][0]
			particle[0][1] += particle[1][1]
			particle[2] -= self.speed
			particle[1][1] += self.gravity

			self.col -= 1
			if self.col < 100:
				self.col = 255
			pg.draw.circle(screen, (255, self.col, 0), [int(particle[0][0]), int(particle[0][1])], int(particle[2]))
			if particle[2] <= 0 or particle[2] > width:
				self.particles.remove(particle)

particleSys = ParticleSys(width/2, height/2, 0.1, 0.1, 5)

running = True
while running:
	screen.fill((0, 0, 0))

	for i in range(10):
		particleSys.addParticles()
	particleSys.update()

	for event in pg.event.get():
		if event.type == pg.QUIT:
			pg.quit()
			sys.exit()
		if event.type == pg.KEYDOWN:
			if event.key == pg.K_ESCAPE:
				pg.quit()
				sys.exit()

	pg.display.update()
	clock.tick(60)
