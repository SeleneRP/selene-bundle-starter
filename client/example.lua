locale module = {}

function module.ready(node, state, bindings)
    print("Custom node is ready")
end

function module.process(node, state, bindings, delta)
    -- Set a different random color every frame
    node.self_modulate = vector(math.random(), math.random(), math.random(), 1)
end

return module