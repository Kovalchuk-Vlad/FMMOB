# Waste collection and close an application 
import os
LoadTime = 66
LiftTime = 3
#win = 7
win = 10
if win == 7:
    doubleClick("TAREOe.png") #win7 IP addr 135
    waitVanish("im.png")
#    
if win == 10:
    doubleClick("ras.png")
    waitVanish("ras.png")
#
wait("o.png", LoadTime)
print ("WasteApp loaded")
# Log driver and select route
while True:
    if exists("aaLogon.png"):
        click("aaLogon.png")
        
#
    if exists ("Y.png"): 
        click(find("Route.png").offset(0,25))
        click("Y.png", LoadTime)
#    
    if exists ("1663081791679.png"):
        click("1663081791679.png")
        break
#    Set manual confirmation mode in Calls page
while True:
    if exists("1663104364460.png"): break

while True:    
    if exists("OK.png"):         click("OK.png")
    click(find("1663104364460.png").offset(10,-600))
    click(find("1663104364460.png").offset(380,-600))    
#    if exists("UTCMANUALCor.png"):         click("eeNFIRM.png"); break

    if exists("SzesPROXIMIT.png"): break
#    execute all calls on the route
while True:
    if exists("OK.png"):                 click("OK.png")  
    if exists("oF13To4.png"):
        click(find("1663104364460.png").offset(250,-600))
        click(find("1663104364460.png").offset(380,-600))           
#    wait(LiftTime) 
    if exists("selstePROXIM.png"):
        click("C.png")
        break    
    if exists("1663083885976.png"):
        if exists("OK.png"):         click("OK.png")    
#        click("COMPLETEDRAJ.png")
        click(find("1663104364460.png").offset(120,0))           
        continue
# close completed routeand exit WasteApp
while True:
    if exists("1663085209853.png"):
        click("1663085209853.png")
    if exists("Closeroute.png"):
        click("Closeroute.png")
    if exists("Exit.png"):
        click("Exit.png")
        break
while True:        
    if exists("SC2.png"):
        click(find("SC2.png").offset(200, 0))
        break
#    Kill all WasteApp processes
while True:
    if win == 7:
        if exists("1662738522329.png"):             doubleClick("1662738522329.png")
        else:
            if exists("aN.png"): doubleClick("aN.png")
print("WasteApp unloaded")
exit(66)
        

        