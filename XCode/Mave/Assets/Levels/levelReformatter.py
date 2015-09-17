#!/usr/bin/python

try:
    import xml.etree.cElementTree as ET
except ImportError:
    import xml.etree.ElementTree as ET
import sys

gidToTag = {'18': 'npcTiles', '14': 'triggerTiles', '22': 'finishTiles'};
tilesTagToGid = {'playerTile': '8', 'npcTiles': '18', 'triggerTiles': '14', 'finishTiles': '22'};

levelDirectory = sys.argv[1]
levelFilepath = levelDirectory+'/'+levelDirectory.lower()+'.tmx'
levelTree = ET.ElementTree(file=levelFilepath)

specialTilesFilepath = levelDirectory+'/'+'specialTiles.xml'
specialTilesTree = ET.ElementTree(file=specialTilesFilepath)

for tilesTag in specialTilesTree.getroot():
	gid = tilesTagToGid[tilesTag.tag]

	index = 0
	for tile in levelTree.iter(tag="tile"):
		if tile.get('gid') == gid:
			data = tilesTag[index]
			index+=1
			for key in data.keys():
				tile.set(key, data.get(key))


#rewrite the level File with the new tree
f = open(levelFilepath, 'r+')
levelTree.write(f)