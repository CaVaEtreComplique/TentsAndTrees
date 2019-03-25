# @Author: Corentin Petit <CorentinPetit>
# @Date:   09-Feb-2019
# @Email:  corentin.petit.etu@univ-lemans.fr
# @Filename: CellAssets.rb
# @Last modified by:   zeigon
# @Last modified time: 25-Mar-2019



require File.dirname(__FILE__) + "/../AssetsClass/CellAsset"

class CellAssets
	@cellAssets
	@cellAssetsSelected
	@cellAssetsFrozen
	@cellAssetsSelectedFrozen

	# @buttons ...
	def initialize(nRows, nCols)
		pathToAssets=File.dirname(__FILE__) + "/../../../Assets/Cells/"
		tentArray = Array.new
		treeArray = Array.new
		lockedTreeArray = Array.new

		tentSelectedArray = Array.new
		treeSelectedArray = Array.new
		lockedTreeSelectedArray = Array.new

		tentArrayFrozen = Array.new
		treeArrayFrozen = Array.new
		lockedTreeArrayFrozen = Array.new

		tentSelectedArrayFrozen = Array.new
		treeSelectedArrayFrozen = Array.new
		lockedTreeSelectedArrayFrozen = Array.new

		ProcessStatus.send("Chargement des textures")
		ProcessStatus.send("Adaptation de textures de la grille à lécran")
		(0...4).each { |x|
			tentArray.push(CellAsset.new(pathToAssets+"tent"+x.to_s+".png",nRows, nCols))
		}
		(0...8).each { |x|
			treeArray.push(CellAsset.new(pathToAssets+"tree"+x.to_s+".png",nRows, nCols))
		}
		(0...8).each { |x|
			lockedTreeArray.push(CellAsset.new(pathToAssets+"tree"+x.to_s+"c.png",nRows, nCols))
		}

		(0...4).each { |x|
			tentSelectedArray.push(CellAsset.new(pathToAssets+"tent"+x.to_s+"Selected.png",nRows, nCols))
		}
		(0...8).each { |x|
			treeSelectedArray.push(CellAsset.new(pathToAssets+"tree"+x.to_s+"Selected.png",nRows, nCols))
		}
		(0...8).each { |x|
			lockedTreeSelectedArray.push(CellAsset.new(pathToAssets+"tree"+x.to_s+"cSelected.png",nRows, nCols))
		}

    # => Frozens Assets

		(0...4).each { |x|
			tentArrayFrozen.push(CellAsset.new(pathToAssets+"tent"+x.to_s+"Frozen.png",nRows, nCols))
		}
		(0...8).each { |x|
			treeArrayFrozen.push(CellAsset.new(pathToAssets+"tree"+x.to_s+"Frozen.png",nRows, nCols))
		}
		(0...8).each { |x|
			lockedTreeArrayFrozen.push(CellAsset.new(pathToAssets+"tree"+x.to_s+"cFrozen.png",nRows, nCols))
		}

		(0...4).each { |x|
			tentSelectedArrayFrozen.push(CellAsset.new(pathToAssets+"tent"+x.to_s+"SelectedFrozen.png",nRows, nCols))
		}
		(0...8).each { |x|
			treeSelectedArrayFrozen.push(CellAsset.new(pathToAssets+"tree"+x.to_s+"SelectedFrozen.png",nRows, nCols))
		}
		(0...8).each { |x|
			lockedTreeSelectedArrayFrozen.push(CellAsset.new(pathToAssets+"tree"+x.to_s+"cSelectedFrozen.png",nRows, nCols))
		}


		@cellAssets = {
			white:  		[CellAsset.new(pathToAssets+"empty.png",nRows, nCols)],
			grass:  		[CellAsset.new(pathToAssets+"grass.png",nRows, nCols)],
			tent:   		tentArray,
			tree:  			treeArray,
			lockedTree: lockedTreeArray
		}

		@cellAssetsSelected = {
			white:  		[CellAsset.new(pathToAssets+"emptySelected.png",nRows, nCols)],
			grass:  		[CellAsset.new(pathToAssets+"grassSelected.png",nRows, nCols)],
			tent:				tentSelectedArray,
			tree:				treeSelectedArray,
			lockedTree:	lockedTreeSelectedArray
		}

		@cellAssetsFrozen = {
			grass:  		[CellAsset.new(pathToAssets+"grassFrozen.png",nRows, nCols)],
			tent:   		tentArrayFrozen,
			tree:  			treeArrayFrozen,
			lockedTree: lockedTreeArrayFrozen
		}

		@cellAssetsSelectedFrozen = {
			grass:  		[CellAsset.new(pathToAssets+"grassSelectedFrozen.png",nRows, nCols)],
			tent:				tentSelectedArrayFrozen,
			tree:				treeSelectedArrayFrozen,
			lockedTree:	lockedTreeSelectedArrayFrozen
		}
	end

	# @buttons ...
	def cellAsset(state=:white,variation=-1,frozen=false)
		case frozen
		when false
			case state
			when :tent
				[@cellAssets[:tent].at( tentNum= (variation==-1 ? Random.new.rand(0...4) : variation) ),tentNum]
			when :tree
				[@cellAssets[:tree].at( treeNum= (variation==-1 ? Random.new.rand(0...8) : variation) ),treeNum]
			when :lockedTree
				[@cellAssets[:lockedTree].at( treeNum= (variation==-1 ? Random.new.rand(0...8) : variation) ),treeNum]
			else
				[@cellAssets[state][0],-1]
			end
		when true
			case state
			when :tent
				[@cellAssetsFrozen[:tent].at( tentNum= (variation==-1 ? Random.new.rand(0...4) : variation) ),tentNum]
			when :tree
				[@cellAssetsFrozen[:tree].at( treeNum= (variation==-1 ? Random.new.rand(0...8) : variation) ),treeNum]
			when :lockedTree
				[@cellAssetsFrozen[:lockedTree].at( treeNum= (variation==-1 ? Random.new.rand(0...8) : variation) ),treeNum]
			else
				[@cellAssetsFrozen[state][0],-1]
			end
		end
	end

	def cellAssetSelected(state,variation=-1,frozen=false)
		case frozen
		when false
			[@cellAssetsSelected[state].at(variation),variation]
		when true
			[@cellAssetsSelectedFrozen[state].at(variation),variation]
		end
	end

	def cellAssetGlowing(state,variation=-1,frozen=false)
		case frozen
		when false
			[@cellAssetsSelected[state].at(variation),variation]
		when true
			[@cellAssetsSelectedFrozen[state].at(variation),variation]
		end
	end

end
