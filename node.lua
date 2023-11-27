gl.setup(NATIVE_WIDTH, NATIVE_HEIGHT)

util.no_globals()

local videos = {
    [16] = resource.load_video{file = "1.mp4", looped = false, audio = true, paused = true},
    [17] = resource.load_video{file = "2.mp4", looped = false, audio = true, paused = true},
    [18] = resource.load_video{file = "3.mp4", looped = false, audio = true, paused = true},
    [19] = resource.load_video{file = "4.mp4", looped = false, audio = true, paused = true},
}

local current_video = nil
local video_playing = false

local function start_video(pin)
    if current_video then
        current_video:stop()
    end
    current_video = videos[pin]
    current_video:start()
    video_playing = true
end

local function stop_video()
    if current_video then
        current_video:stop()
    end
    current_video = nil
    video_playing = false
end

util.data_mapper{
    ["state/16"] = function(state)
        if state == '1' then
            start_video(16)
        elseif state == '0' then
            stop_video()
        end
    end,
    ["state/17"] = function(state)
        if state == '1' then
            start_video(17)
        elseif state == '0' then
            stop_video()
        end
    end,
    ["state/18"] = function(state)
        if state == '1' then
            start_video(18)
        elseif state == '0' then
            stop_video()
        end
    end,
    ["state/19"] = function(state)
        if state == '1' then
            start_video(19)
        elseif state == '0' then
            stop_video()
        end
    end,
}

function node.render()
    if video_playing and current_video then
        local video_state, w, h = current_video:state()
        if video_state == "finished" then
            stop_video()
            gl.clear(1, 0, 0, 1) -- red, default state
        else
            current_video:draw(0, 0, WIDTH, HEIGHT)
        end
    else
        gl.clear(1, 0, 0, 1) -- red, default state
    end
end
