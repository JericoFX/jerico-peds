local QBCore = exports["qb-core"]:GetCoreObject()
local Menu = {
  function()
    local player = QBCore.Functions.GetPlayerData().citizenid
    local data = lib.callback.await("jerico-peds:server:getPedsByCitizenId", 500, player)
    if type(data) == "table" then
      for k, _ in pairs(data) do
        local d = data[k]
        lib.setMenuOptions("menu_ped_handler", { label = d.name, description = 'awwa', args = d.hash }, k)
      end
    else
      lib.setMenuOptions("menu_ped_handler", {
        { label = 'NO PED ', description = 'no', disabled = true },
      })
    end
    -- print(json.encode(data, { indent = true }))
    lib.showMenu("menu_ped_handler")
  end,
  function()
    NetworkFadeOutEntity(cache.playerId, false, true)
    Wait(200)
    TriggerEvent("illenium-appearance:client:reloadSkin") -- LOADING PLAYER'S CLOTHES
    --TriggerServerEvent("qb-clothing:loadPlayerSkin") -- LOADING PLAYER'S CLOTHES - Event 2
    Wait(200)
    NetworkFadeInEntity(cache.ped, false)
  end,
  function()
    lib.hideMenu()
  end
}
CreateThread(function()
  lib.registerMenu({
    id = 'menu_index',
    title = 'Ped Menu',
    position = 'top-right',
    onSelected = function(selected)
    end,
    options = {
      { label = 'Select Ped',  description = 'Select your new ped!' },
      { label = 'Restart Ped', description = 'Go back to the old one!' },
      { label = 'Close Menu',  description = 'Close the menu' },
    }
  }, function(selected, scrollIndex, args)
    Menu[selected]()
  end)

  lib.registerMenu({
      id = 'menu_ped_handler',
      title = 'Ped Selection',
      position = 'top-right',
      onSelected = function(selected)
      end,
      options = {}
    },
    function(selected, scrollIndex, args)
      local model = args
      NetworkFadeOutEntity(cache.playerId, false, true)
      Wait(500)
      if IsModelInCdimage(model) and IsModelValid(model) then
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end
        SetPlayerModel(cache.playerId, model)
        SetPedRandomComponentVariation(cache.ped, 1)
        SetModelAsNoLongerNeeded(model)
      end
      Wait(500)
      NetworkFadeInEntity(cache.ped, false)
    end)
end)
RegisterCommand("selectPed", function(source, args)
  lib.showMenu("menu_index")
end, false)
