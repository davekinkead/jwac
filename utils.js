

var createBuckets = function(data) {
  var buckets = []

  data.forEach(function(member) {
    member.postings.forEach(function(posting, i) {
      if (buckets[i] == undefined)
        buckets[i] = {};
      if (buckets[i].hasOwnProperty(posting.billet)) {
        buckets[i][posting.billet].push(member.id);
      } else {
        buckets[i][posting.billet] = [member.id];
      }
    });
  });

  return buckets;    
}

var createNodes = function(buckets) {
  var gate = 0;

  return [].concat.apply([], buckets.map(function(bucket) {
    var nodes = Object.keys(bucket).map(function(name) {
      return {"name": name, "members": bucket[name], "gate": gate }
    });
    gate++;

    return nodes.sort(function(a, b) {
      if (a.gate == b.gate)
        return b.members.length - a.members.length;
      else
        return a.gate - b.gate;
    });
  }));
}

var createLinks = function(nodes) {
  var links = Array.apply(null, Array(nodes.length)).map(function() { return []; });

  nodes.forEach(function(node, index) {
    nodes.forEach(function(n, i) {
      if (node.gate == n.gate - 1 && index !== i)
        node.members.forEach(function(id) {
          if (n.members.indexOf(id) !== -1)
            if (links[index].hasOwnProperty(i))
              links[index][i] += 1;
            else
              links[index][i] = 1;
        });
    });
  });

  var results = []
  links.forEach(function(array, index) {
    array.forEach(function(el, i) {
      results.push ({"source": index, "target": i, "value": el});
    });        
  });
  return results;
}

var createDatedNodesFromPostingHistory = function(history) {
  var results = {};

  history.forEach(function(row) {
    row.postings.forEach(function(p, i) {
        if (!results.hasOwnProperty(p.billet))
          results[p.billet] = {};
        if (!results[p.billet].hasOwnProperty(p.start))      
          results[p.billet][p.start] = {"billet": p.billet, "start": new Date(p.start), "finish": new Date(p.finish), "members": []};
        results[p.billet][p.start].members.push(row.id);
    });
  });
  return [].concat.apply([], Object.keys(results).map(function(b) {
    return Object.keys(results[b]).map(function(d) {
      return results[b][d];
    });
  })).sort(function(a, b) {
    return b.members.length - a.members.length;
  }).sort(function(a, b) {
    return a.start - b.start;
  });
}

var convertToDays = function(milliseconds) {
  return milliseconds / (1000 * 60 * 60 * 24)
}

var calculateOverlap = function(node, nodes) {

}