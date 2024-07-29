import argparse
import sys, os
from PySide6 import QtCore, QtWidgets, QtGui
from PIL import Image, ImageQt


class Interface_BlocksetEdit(QtWidgets.QMainWindow):
    def __init__(self, args):
        super().__init__()
        
        # variables
        self.recent_folder = None
        
        self.tiles_bg_path = None
        self.tiles_hud_path = None
        self.tiles_enemy_path = None
        self.collision_path = None
        self.metatiles_path = None
        self.attribs_path = None
        self.palettes_path = None
        
        self.tiles = []
        self.collision = []
        self.metatiles = []
        self.attribs = []
        self.palettes = []
        
        self.cur_block = None
        self.cur_block_tile = None
        
        # controls
        self.menubar = self.menuBar()
        
        self.menubar_file = QtWidgets.QMenu()
        self.menubar_file.setTitle("File")
        self.menubar.addMenu(self.menubar_file)

        self.menubar_file_load_tiles_bg = QtGui.QAction("Load background CHR...")
        self.menubar_file.addAction(self.menubar_file_load_tiles_bg)
        
        self.menubar_file_load_tiles_hud = QtGui.QAction("Load hud CHR...")
        self.menubar_file.addAction(self.menubar_file_load_tiles_hud)
        
        self.menubar_file_load_tiles_enemy = QtGui.QAction("Load enemy CHR...")
        self.menubar_file.addAction(self.menubar_file_load_tiles_enemy)
        
        self.menubar_file_load_collision = QtGui.QAction("Load collision...")
        self.menubar_file.addAction(self.menubar_file_load_collision)
        
        self.menubar_file_load_metatiles = QtGui.QAction("Load metatiles...")
        self.menubar_file.addAction(self.menubar_file_load_metatiles)
        
        self.menubar_file_load_attribs = QtGui.QAction("Load color attribs...")
        self.menubar_file.addAction(self.menubar_file_load_attribs)
        
        self.menubar_file_load_palettes = QtGui.QAction("Load color palettes...")
        self.menubar_file.addAction(self.menubar_file_load_palettes)
        
        self.menubar_file_save_collision = QtGui.QAction("Save collision...")
        self.menubar_file.addAction(self.menubar_file_save_collision)
        
        self.menubar_file_save_metatiles = QtGui.QAction("Save metatiles...")
        self.menubar_file.addAction(self.menubar_file_save_metatiles)
        
        self.menubar_file_save_attribs = QtGui.QAction("Save color attribs...")
        self.menubar_file.addAction(self.menubar_file_save_attribs)
        
        self.menubar_file_save_palettes = QtGui.QAction("Save color palettes...")
        self.menubar_file.addAction(self.menubar_file_save_palettes)
        
        self.root = QtWidgets.QGridLayout()
        self.root_widget = QtWidgets.QWidget()
        self.root_widget.setLayout(self.root)
        self.setCentralWidget(self.root_widget)
        
        self.root_tileset_view = QtWidgets.QGraphicsView()
        self.root_tileset_view.setFixedSize(256, 256)
        self.root_tileset_view.setViewportMargins(-2, -2, -2, -2)
        self.root.addWidget(self.root_tileset_view, 0, 0, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)

        self.root_tileset_scene = QtWidgets.QGraphicsScene()
        self.root_tileset_view.setScene(self.root_tileset_scene)
        
        self.root_blockset_view = QtWidgets.QGraphicsView()
        self.root_blockset_view.setFixedSize(512, 256)
        self.root_blockset_view.setViewportMargins(-2, -2, -2, -2)
        self.root.addWidget(self.root_blockset_view, 1, 0, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)

        self.root_blockset_scene = QtWidgets.QGraphicsScene()
        self.root_blockset_view.setScene(self.root_blockset_scene)
        
        self.root_blockedit = QtWidgets.QGridLayout()
        self.root_blockedit_widget = QtWidgets.QWidget()
        self.root_blockedit_widget.setLayout(self.root_blockedit)
        self.root.addWidget(self.root_blockedit_widget, 0, 1, 2, 1, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_palette_bg = QtWidgets.QGridLayout()
        self.root_palette_bg.setSpacing(0)
        self.root_palette_bg_widget = QtWidgets.QWidget()
        self.root_palette_bg_widget.setLayout(self.root_palette_bg)
        self.root_blockedit.addWidget(self.root_palette_bg_widget, 0, 0, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_palette_bg_button = []
        for i in range(8):
            self.root_palette_bg_button.append([])
            for j in range(4):
                self.root_palette_bg_button[i].append(QtWidgets.QPushButton())
                self.root_palette_bg_button[i][j].setFixedSize(20, 20)
                self.root_palette_bg.addWidget(self.root_palette_bg_button[i][j], i, j, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_palette_obj = QtWidgets.QGridLayout()
        self.root_palette_obj.setSpacing(0)
        self.root_palette_obj_widget = QtWidgets.QWidget()
        self.root_palette_obj_widget.setLayout(self.root_palette_obj)
        self.root_blockedit.addWidget(self.root_palette_obj_widget, 0, 1, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_palette_obj_button = []
        for i in range(8):
            self.root_palette_obj_button.append([])
            for j in range(4):
                self.root_palette_obj_button[i].append(QtWidgets.QPushButton())
                self.root_palette_obj_button[i][j].setFixedSize(20, 20)
                self.root_palette_obj.addWidget(self.root_palette_obj_button[i][j], i, j, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)   
        
        self.root_blockedit_block_label = QtWidgets.QLabel()
        self.root_blockedit_block_label.setWordWrap(True)
        self.root_blockedit.addWidget(self.root_blockedit_block_label, 1, 0, 1, 2, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_blockedit_block_view = QtWidgets.QGraphicsView()
        self.root_blockedit_block_view.setFixedSize(64, 64)
        self.root_blockedit_block_view.setViewportMargins(-2, -2, -2, -2)
        self.root_blockedit.addWidget(self.root_blockedit_block_view, 2, 0, 1, 2, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_blockedit_block_scene = QtWidgets.QGraphicsScene()
        self.root_blockedit_block_view.setScene(self.root_blockedit_block_scene)
        
        self.root_blockedit_collision = [
            QtWidgets.QCheckBox(text="Water"),
            QtWidgets.QCheckBox(text="Platform"),
            QtWidgets.QCheckBox(text="Anti-platform"),
            QtWidgets.QCheckBox(text="Spike"),
            QtWidgets.QCheckBox(text="Acid"),
            QtWidgets.QCheckBox(text="Shot block"),
            QtWidgets.QCheckBox(text="Bomb block"),
            QtWidgets.QCheckBox(text="Save station")
        ]
        for i in range(len(self.root_blockedit_collision)):
            self.root_blockedit.addWidget(self.root_blockedit_collision[i], i+3, 0, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_blockedit_attribs_color = QtWidgets.QComboBox()
        self.root_blockedit_attribs_color.addItems(["Palette " + str(i) for i in range(8)])
        self.root_blockedit.addWidget(self.root_blockedit_attribs_color, 3, 1, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        self.root_blockedit_attribs = [
            QtWidgets.QCheckBox(text="Alt VRAM Bank"),
            QtWidgets.QCheckBox(text="Unused"),
            QtWidgets.QCheckBox(text="X flip"),
            QtWidgets.QCheckBox(text="Y flip"),
            QtWidgets.QCheckBox(text="Priority")
        ]
        for i in range(len(self.root_blockedit_attribs)):
            self.root_blockedit.addWidget(self.root_blockedit_attribs[i], i+4, 1, alignment=QtCore.Qt.AlignmentFlag.AlignCenter)
        
        # init function calls
        for i in range(0x100):
            self.tiles.append(None)
        self.tiles[0xff] = Image.new("P", (8, 8))
        
        if args.hud is not None:
            self.tiles_hud_load(args.hud)
        if args.enemy is not None:
            self.tiles_enemy_load(args.enemy)
            
        self.recent_folder = "SRC/tilesets"
        
        if args.tiles is not None:
            self.tiles_bg_load(args.tiles)
        if args.coll is not None:
            self.collision_load(args.coll)
        if args.meta is not None:
            self.metatiles_load(args.meta)
        if args.attr is not None:
            self.attribs_load(args.attr)
        if args.pal is not None:
            self.palettes_load(args.pal)
        self.blockedit_block_update_interface()
        
        # controller
        self.menubar_file_load_tiles_bg.triggered.connect(lambda: self.tiles_bg_load())
        self.menubar_file_load_tiles_hud.triggered.connect(lambda: self.tiles_hud_load())
        self.menubar_file_load_tiles_enemy.triggered.connect(lambda: self.tiles_enemy_load())
        self.menubar_file_load_collision.triggered.connect(lambda: self.collision_load())
        self.menubar_file_load_metatiles.triggered.connect(lambda: self.metatiles_load())
        self.menubar_file_load_attribs.triggered.connect(lambda: self.attribs_load())
        self.menubar_file_load_palettes.triggered.connect(lambda: self.palettes_load())
        self.menubar_file_save_collision.triggered.connect(lambda: self.collision_save())
        self.menubar_file_save_metatiles.triggered.connect(lambda: self.metatiles_save())
        self.menubar_file_save_attribs.triggered.connect(lambda: self.attribs_save())
        self.menubar_file_save_palettes.triggered.connect(lambda: self.palettes_save())
        self.root_tileset_scene.mousePressEvent = self.tileset_on_click
        self.root_blockset_scene.mousePressEvent = self.blockset_on_click
        self.root_blockedit_block_scene.mousePressEvent = self.blockedit_block_on_click
        for checkbox in self.root_blockedit_collision:
            checkbox.clicked.connect(self.blockedit_collision_on_click)
        for checkbox in self.root_blockedit_attribs:
            checkbox.clicked.connect(self.blockedit_attribs_on_click)
        self.root_blockedit_attribs_color.activated.connect(self.blockedit_attribs_color_on_change)
        for palette in self.root_palette_bg_button:
            for button in palette:
                button.clicked.connect(self.palette_bg_button_on_click)
        for palette in self.root_palette_obj_button:
            for button in palette:
                button.clicked.connect(self.palette_obj_button_on_click)
                
                
    
    
    def tiles_bg_load(self, file_name=None):
        if file_name == None:
            file_name, _ = QtWidgets.QFileDialog.getOpenFileName(caption="Load background CHR", dir=self.recent_folder)
            if file_name == "":
                return
        self.recent_folder = os.path.dirname(file_name)
        self.tiles_bg_path = file_name
        
        for i in range(0x00, 0x80):
            self.tiles[i] = None
            
        with open(file_name, "rb") as f:
            tile_data = f.read()
        
        if len(tile_data) % 16 != 0:
            raise Exception("incomplete tile found in bg tile file: file size (" + str(len(tile_data)) + " bytes) mod 16 == " + str(len(tile_data) % 16))
        
        for i in range(0, min(len(tile_data), 0x800), 0x10):
            self.tiles[i//16] = self.get_tile_indexed_image(tile_data[i:i+16])
        
        self.tileset_update_interface()
        self.blockset_update_interface()
    
    
    def tiles_hud_load(self, file_name=None):
        if file_name == None:
            file_name, _ = QtWidgets.QFileDialog.getOpenFileName(caption="Load background CHR", dir=self.recent_folder)
            if file_name == "":
                return
        self.recent_folder = os.path.dirname(file_name)
        self.tiles_hud_path = file_name
        
        for i in range(0x80, 0xb0):
            self.tiles[i] = None
            
        with open(file_name, "rb") as f:
            tile_data = f.read()
        
        if len(tile_data) % 16 != 0:
            raise Exception("incomplete tile found in hud tile file: file size (" + str(len(tile_data)) + " bytes) mod 16 == " + str(len(tile_data) % 16))
        
        for i in range(0x800, 0xb00, 0x10):
            self.tiles[i//16] = self.get_tile_indexed_image(tile_data[i:i+16])
            
        self.tileset_update_interface()
        self.blockset_update_interface()
    
    
    def tiles_enemy_load(self, file_name=None):
        if file_name == None:
            file_name, _ = QtWidgets.QFileDialog.getOpenFileName(caption="Load enemy CHR", dir=self.recent_folder)
            if file_name == "":
                return
        self.recent_folder = os.path.dirname(file_name)
        self.tiles_enemy_path = file_name
        
        for i in range(0xb0, 0xff):
            self.tiles[i] = None
            
        with open(file_name, "rb") as f:
            tile_data = f.read()
        
        if len(tile_data) % 16 != 0:
            raise Exception("incomplete tile found in enemy tile file: file size (" + str(len(tile_data)) + " bytes) mod 16 == " + str(len(tile_data) % 16))
        
        for i in range(0, min(len(tile_data), 0x4f0), 0x10):
            self.tiles[0xb0+i//16] = self.get_tile_indexed_image(tile_data[i:i+16])
            
        self.tileset_update_interface()
        self.blockset_update_interface()
    
    
    def tileset_on_click(self, mouse_event):
        if len(self.metatiles) == 0 or len(self.tiles) == 0:
            return
        if self.cur_block is None or self.cur_block_tile is None:
            return
        x = int(mouse_event.scenePos().x() // 16)
        y = int(mouse_event.scenePos().y() // 16)
        self.metatiles[self.cur_block*4 + self.cur_block_tile] = y*16 + x
        
        self.blockset_update_interface()
        self.blockedit_block_update_interface()
    
    
    def tileset_update_interface(self):
        for i in range(0x100):
            if self.tiles[i] is None:
                continue
            x = i % 16
            y = i // 16
            qimage = ImageQt.ImageQt(self.tiles[i])
            pixmap = QtGui.QPixmap.fromImage(qimage).scaled(16, 16)
            pixmap_item = QtWidgets.QGraphicsPixmapItem()
            pixmap_item.setPixmap(pixmap)
            pixmap_item.setPos(x * 16, y * 16)
            self.root_tileset_scene.addItem(pixmap_item)


    def get_tile_indexed_image(self, data):
        tile_img = Image.new("P", (8, 8))
        tile_img.putpalette((
            0, 0, 0,
            255, 255, 255,
            170, 170, 170,
            85, 85, 85,
        ), "RGB")
        for y in range(8):
            byte1 = int(data[y*2])
            byte2 = int(data[y*2+1])
            for x in range(7, -1, -1):
                pixel = (byte1&1) + (byte2&1)*2
                tile_img.putpixel((x, y), pixel)
                byte1 = byte1 >> 1
                byte2 = byte2 >> 1
        return tile_img


    def collision_load(self, file_name=None):
        if file_name == None:
            file_name, _ = QtWidgets.QFileDialog.getOpenFileName(caption="Load collision", dir=self.recent_folder)
            if file_name == "":
                return
        self.recent_folder = os.path.dirname(file_name)
        self.collision_path = file_name
        
        self.collision = []
            
        with open(file_name, "r") as f:
            lines = f.readlines()
        
        for line in lines:
            line = line.split(";")[0].strip()
            if not line.startswith("db "):
                continue
            line = line.replace("db ", "").split(",")
            line = [byte.replace("$", "").strip() for byte in line]
            line = [int(byte, 16) for byte in line if len(byte) > 0]
            self.collision += line
            
        self.blockset_update_interface()
    
    
    def metatiles_load(self, file_name=None):
        if file_name == None:
            file_name, _ = QtWidgets.QFileDialog.getOpenFileName(caption="Load metatiles", dir=self.recent_folder)
            if file_name == "":
                return
        self.recent_folder = os.path.dirname(file_name)
        self.metatiles_path = file_name
        
        self.metatiles = []
            
        with open(file_name, "r") as f:
            lines = f.readlines()
        
        for line in lines:
            line = line.split(";")[0].strip()
            if not line.startswith("db "):
                continue
            line = line.replace("db ", "").split(",")
            line = [byte.replace("$", "").strip() for byte in line]
            line = [int(byte, 16) for byte in line if len(byte) > 0]
            self.metatiles += line
            
        self.blockset_update_interface()
        
        
    def attribs_load(self, file_name=None):
        if file_name == None:
            file_name, _ = QtWidgets.QFileDialog.getOpenFileName(caption="Load attribs", dir=self.recent_folder)
            if file_name == "":
                return
        self.recent_folder = os.path.dirname(file_name)
        self.attribs_path = file_name
        
        self.attribs = []
            
        with open(file_name, "r") as f:
            lines = f.readlines()
        
        for line in lines:
            line = line.split(";")[0].strip()
            if not line.startswith("db "):
                continue
            line = line.replace("db ", "").split(",")
            line = [byte.replace("$", "").strip() for byte in line]
            line = [int(byte, 16) for byte in line if len(byte) > 0]
            self.attribs += line
            
        self.blockset_update_interface()
        
        
    def palettes_load(self, file_name=None):
        if file_name == None:
            file_name, _ = QtWidgets.QFileDialog.getOpenFileName(caption="Load palettes", dir=self.recent_folder)
            if file_name == "":
                return
        self.recent_folder = os.path.dirname(file_name)
        self.palettes_path = file_name
        
        self.palettes = []
            
        with open(file_name, "r") as f:
            lines = f.readlines()
        
        for line in lines:
            line = line.split(";")[0].strip()
            if line.startswith("dw "):
                line = line.replace("dw ", "").split(",")
                line = [word.replace("$", "").strip() for word in line]
                line = [int(word, 16) for word in line if len(word) > 0]
                line = [int(round((x&0x1f)*255/0x1f)) for word in line for x in [word, word>>5, word>>10]]
            elif line.startswith("Palette "):
                line = line = line.replace("Palette ", "").split(",")
                line = [rgbhex.replace("$", "").strip() for rgbhex in line]
                line = [int(rgbhex, 16) for rgbhex in line if len(rgbhex) > 0]
                line = [int(x&0xff) for rgbhex in line for x in [rgbhex>>16, rgbhex>>8, rgbhex]]
            else:
                continue
            self.palettes.append(line)
            
        self.palettes_update_interface()
        self.blockset_update_interface()
    
    
    def blockset_update_interface(self):
        for item in self.root_blockset_scene.items():
            self.root_blockset_scene.removeItem(item)
        if len(self.metatiles) == 0 or len(self.tiles) == 0:
            return
        for i in range(0x80): # plz crash if no full 128 blocks
            x = i % 16
            y = i // 16
            for xx in range(2):
                for yy in range(2):
                    index = i * 4 + yy * 2 + xx
                    tile = self.tiles[self.metatiles[index]].copy()
                    if len(self.attribs) > 0:
                        if self.attribs[index] & 0x20 != 0:
                            tile = tile.transpose(Image.FLIP_LEFT_RIGHT)
                        if self.attribs[index] & 0x40 != 0:
                            tile = tile.transpose(Image.FLIP_TOP_BOTTOM)
                        if len(self.palettes) > 0:
                            tile.putpalette(self.palettes[self.attribs[index] & 0x07], "RGB")
                        
                    qimage = ImageQt.ImageQt(tile)
                    pixmap = QtGui.QPixmap.fromImage(qimage).scaled(16, 16)
                    pixmap_item = QtWidgets.QGraphicsPixmapItem()
                    pixmap_item.setPixmap(pixmap)
                    pixmap_item.setPos(x * 32 + xx * 16, y * 32 + yy * 16)
                    self.root_blockset_scene.addItem(pixmap_item)
    
    
    def blockset_on_click(self, mouse_event):
        if len(self.metatiles) == 0 or len(self.tiles) == 0:
            return
        x = int(mouse_event.scenePos().x() // 32)
        y = int(mouse_event.scenePos().y() // 32)
        self.cur_block = y*16 + x
        self.cur_block_tile = None
        self.blockedit_block_update_interface()
        
        
        
    def blockedit_block_on_click(self, mouse_event):
        if len(self.metatiles) == 0 or len(self.tiles) == 0:
            return
        if self.cur_block == None:
            return
        x = int(mouse_event.scenePos().x() // 32)
        y = int(mouse_event.scenePos().y() // 32)
        self.cur_block_tile = y*2 + x
        self.blockedit_block_update_interface()
        
        
    def blockedit_block_update_interface(self):
        block_corner_name = "No" if self.cur_block_tile is None else ["Top-left", "Top-right", "Bottom-left", "Bottom-right"][self.cur_block_tile]
        block_num = "None\n" if self.cur_block is None else "${:02X}\n".format(self.cur_block)
        tile_num = "" if self.cur_block_tile is None else "${:02X}".format(self.metatiles[self.cur_block * 4 + self.cur_block_tile])
        self.root_blockedit_block_label.setText("Block " + block_num + block_corner_name + " tile " + tile_num)
        for item in self.root_blockedit_block_scene.items():
            self.root_blockedit_block_scene.removeItem(item)
           
        for checkbox in self.root_blockedit_collision:
            checkbox.setEnabled(False)
            checkbox.setChecked(False)
        self.root_blockedit_attribs_color.setEnabled(False)
        self.root_blockedit_attribs_color.setCurrentIndex(-1)
        for checkbox in self.root_blockedit_attribs:
            checkbox.setEnabled(False)
            checkbox.setChecked(False)
            
        if len(self.metatiles) == 0 or len(self.tiles) == 0:
            return
        if self.cur_block == None:
            return
        for xx in range(2):
            for yy in range(2):
                index = self.cur_block * 4 + yy * 2 + xx
                tile = self.tiles[self.metatiles[index]].copy()
                if len(self.attribs) > 0:
                    if self.attribs[index] & 0x20 != 0:
                        tile = tile.transpose(Image.FLIP_LEFT_RIGHT)
                    if self.attribs[index] & 0x40 != 0:
                        tile = tile.transpose(Image.FLIP_TOP_BOTTOM)
                    if len(self.palettes) > 0:
                        tile.putpalette(self.palettes[self.attribs[index] & 0x07], "RGB")
                    
                qimage = ImageQt.ImageQt(tile)
                pixmap = QtGui.QPixmap.fromImage(qimage).scaled(32, 32)
                pixmap_item = QtWidgets.QGraphicsPixmapItem()
                pixmap_item.setPixmap(pixmap)
                pixmap_item.setPos(xx * 32, yy * 32)
                self.root_blockedit_block_scene.addItem(pixmap_item)
        
        if self.cur_block_tile is None:
            return
        
        if len(self.collision) > 0:
            tile_id = self.metatiles[self.cur_block * 4 + self.cur_block_tile]
            for i in range(len(self.root_blockedit_collision)):
                flag = 1<<i
                self.root_blockedit_collision[i].setEnabled(True)
                self.root_blockedit_collision[i].setChecked(self.collision[tile_id] & flag != 0)
        
        if len(self.attribs) > 0:
            self.root_blockedit_attribs_color.setEnabled(True)
            self.root_blockedit_attribs_color.setCurrentIndex(self.attribs[self.cur_block * 4 + self.cur_block_tile] & 0x07)
            for i in range(len(self.root_blockedit_attribs)):
                flag = 8<<i
                self.root_blockedit_attribs[i].setEnabled(True)
                self.root_blockedit_attribs[i].setChecked(self.attribs[self.cur_block * 4 + self.cur_block_tile] & flag != 0)
    
    
    def blockedit_collision_on_click(self, checked):
        tile_id = self.metatiles[self.cur_block * 4 + self.cur_block_tile]
        flag = 1 << self.root_blockedit_collision.index(self.sender())
        self.collision[tile_id] = (self.collision[tile_id] & (0xff ^ flag)) + (flag if checked else 0)
    
    
    def blockedit_attribs_on_click(self, checked):
        index = self.cur_block * 4 + self.cur_block_tile
        flag = 8 << self.root_blockedit_attribs.index(self.sender())
        self.attribs[index] = (self.attribs[index] & (0xff ^ flag)) + (flag if checked else 0)
        self.blockset_update_interface()
        self.blockedit_block_update_interface()
    
    
    def blockedit_attribs_color_on_change(self, value):
        index = self.cur_block * 4 + self.cur_block_tile
        self.attribs[index] = (self.attribs[index] & 0xf8) + value
        self.blockset_update_interface()
        self.blockedit_block_update_interface()
        
    
    def collision_save(self):
        file_content = "; " + os.path.basename(self.collision_path) + "\n"
        file_content += "; Saved using edit_blockset.py\n"
        for i in range(0, len(self.collision), 16):
            line = self.collision[i:min(i+16, len(self.collision))]
            file_content += "    db " + ", ".join(["${:02X}".format(b) for b in line]) + "\n"
        
        with open(self.collision_path, "w") as f:
            f.write(file_content)
        
        
    def metatiles_save(self):
        file_content = "; " + os.path.basename(self.metatiles_path) + "\n"
        file_content += "; Saved using edit_blockset.py\n"
        for i in range(0, len(self.metatiles), 16):
            line = self.metatiles[i:min(i+16, len(self.metatiles))]
            file_content += "    db " + ", ".join(["${:02X}".format(b) for b in line]) + "\n"
        
        with open(self.metatiles_path, "w") as f:
            f.write(file_content)
        
        
    def attribs_save(self):
        file_content = "; " + os.path.basename(self.attribs_path) + "\n"
        file_content += "; Saved using edit_blockset.py\n"
        for i in range(0, len(self.attribs), 16):
            line = self.attribs[i:min(i+16, len(self.attribs))]
            file_content += "    db " + ", ".join(["${:02X}".format(b) for b in line]) + "\n"
        
        with open(self.attribs_path, "w") as f:
            f.write(file_content)
    
    
    def palettes_update_interface(self):
        if len(self.palettes) == 0:
            return
        for i in range(8):
            for j in range(4):
                rgb = self.palettes[i][j*3:(j+1)*3]
                color = QtGui.QColor(rgb[0], rgb[1], rgb[2])
                self.root_palette_bg_button[i][j].setStyleSheet('QPushButton {background-color: ' + color.name(QtGui.QColor.HexRgb) + '}')
                
                rgb = self.palettes[i+8][j*3:(j+1)*3]
                color = QtGui.QColor(rgb[0], rgb[1], rgb[2])
                self.root_palette_obj_button[i][j].setStyleSheet('QPushButton {background-color: ' + color.name(QtGui.QColor.HexRgb) + '}')
        
    
    def palette_bg_button_on_click(self):
        if len(self.palettes) == 0:
            return
        index = [button for palette in self.root_palette_bg_button for button in palette].index(self.sender()) + 0
        rgb = self.palettes[index//4][(index%4)*3:((index%4)+1)*3]
        dialog = QtWidgets.QColorDialog()
        dialog.setOptions(QtWidgets.QColorDialog.DontUseNativeDialog)
        dialog.setCurrentColor(QtGui.QColor(rgb[0], rgb[1], rgb[2]))
        dialog.exec()
        if not dialog.selectedColor().isValid():
            return
        self.palettes[index//4][(index%4)*3+0] = dialog.selectedColor().red()
        self.palettes[index//4][(index%4)*3+1] = dialog.selectedColor().green()
        self.palettes[index//4][(index%4)*3+2] = dialog.selectedColor().blue()
        self.palettes_update_interface()
        self.blockset_update_interface()
        self.blockedit_block_update_interface()
        
        
    def palette_obj_button_on_click(self):
        if len(self.palettes) == 0:
            return
        index = [button for palette in self.root_palette_obj_button for button in palette].index(self.sender()) + 32
        rgb = self.palettes[index//4][(index%4)*3:((index%4)+1)*3]
        dialog = QtWidgets.QColorDialog()
        dialog.setOptions(QtWidgets.QColorDialog.DontUseNativeDialog)
        dialog.setCurrentColor(QtGui.QColor(rgb[0], rgb[1], rgb[2]))
        dialog.exec()
        if not dialog.selectedColor().isValid():
            return
        self.palettes[index//4][(index%4)*3+0] = dialog.selectedColor().red()
        self.palettes[index//4][(index%4)*3+1] = dialog.selectedColor().green()
        self.palettes[index//4][(index%4)*3+2] = dialog.selectedColor().blue()
        self.palettes_update_interface()
        self.blockset_update_interface()
        self.blockedit_block_update_interface()
    
    
    def palettes_save(self):
        file_content = "; " + os.path.basename(self.palettes_path) + "\n"
        file_content += "; Saved using edit_blockset.py\n"
        for palette in self.palettes:
            line = []
            for i in range(4):
                line.append((palette[i*3+0]<<16) + (palette[i*3+1]<<8) + palette[i*3+2])
            file_content += "    Palette " + ", ".join(["${:06X}".format(rgb) for rgb in line]) + "\n"
        
        with open(self.palettes_path, "w") as f:
            f.write(file_content)
    
        
if __name__ == "__main__":
    ap = argparse.ArgumentParser()
    ap.add_argument('-t','--tiles', help='Input tileset CHR')
    ap.add_argument('-d','--hud', help='Input hud CHR')
    ap.add_argument('-e','--enemy', default='./SRC/gfx/enemies/surfaceSPR.2bpp', help='Input enemy CHR')
    ap.add_argument('-c','--coll', help='Input collision ASM')
    ap.add_argument('-m','--meta', help='Input metatiles ASM')
    ap.add_argument('-a','--attr', help='Input attribs ASM')
    ap.add_argument('-p','--pal', help='Input palettes ASM')
    args = ap.parse_args()

    app = QtWidgets.QApplication([])

    widget = Interface_BlocksetEdit(args)
    widget.show()

    sys.exit(app.exec())   

